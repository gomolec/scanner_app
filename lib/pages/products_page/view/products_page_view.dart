import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:scanner_app/pages/products_page/models/models.dart';
import '../../../repositories/repositories.dart';
import '../../../routes/router.gr.dart';
import '../../../widgets/widgets.dart';
import '../bloc/products_bloc/products_bloc.dart';
import 'widgets/widgets.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsBloc(
        productsRepository: context.read<ProductsRepository>(),
        productsHistoryRepository: context.read<ProductsHistoryRepository>(),
      )..add(const ProductsSubscriptionRequested()),
      child: const ProductsPageView(),
    );
  }
}

class ProductsPageView extends StatelessWidget {
  const ProductsPageView({Key? key}) : super(key: key);

  static final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsBloc, ProductsState>(
        builder: (context, state) {
          if (state.status == ProductsStatus.success) {
            return Scrollbar(
              controller: scrollController,
              interactive: true,
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverAppBar.medium(
                    title: const Text("Produkty"),
                    actions: [
                      // IconButton(
                      //   onPressed: () {},
                      //   tooltip: "Zaznacz",
                      //   icon: const Icon(Icons.check_box_outlined),
                      // ),
                      IconButton(
                        color: !state.filter.isDefault
                            ? Theme.of(context).colorScheme.primary
                            : null,
                        onPressed: ([bool mounted = true]) async {
                          final filter =
                              await showModalBottomSheet<ProductsFilter>(
                            isScrollControlled: true,
                            elevation: 1.0,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(28.0)),
                            ),
                            context: context,
                            builder: (BuildContext context) {
                              return SortingBottomSheet(
                                initialFilter: state.filter,
                              );
                            },
                          );
                          if (filter != null) {
                            if (!mounted) return;
                            context.read<ProductsBloc>().add(
                                  ProductsApplyFilter(filter),
                                );
                          }
                        },
                        tooltip: "Filtruj",
                        icon: const Icon(Icons.filter_alt_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          context.router.push(SingleProductRouter());
                        },
                        tooltip: "Nowy produkt",
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SearchBar(
                          onSubmitted: (value) => context
                              .read<ProductsBloc>()
                              .add(ProductsQueried(value)),
                        ),
                        const Divider(
                          height: 8,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  () {
                    if (state.products.isNotEmpty) {
                      return SliverList(
                        delegate: SliverChildBuilderDelegate(
                          (BuildContext context, int index) {
                            return Column(
                              children: [
                                ProductTile(
                                  product: state.products[index],
                                ),
                                const Divider(
                                  height: 8,
                                  thickness: 1,
                                  indent: 16,
                                  endIndent: 16,
                                ),
                              ],
                            );
                          },
                          childCount: state.products.length,
                        ),
                      );
                    } else {
                      if (state.query.isNotEmpty || !state.filter.isDefault) {
                        return const SliverToBoxAdapter(
                          child: PageAlert(
                            leadingIconData: Icons.search_off_rounded,
                            title: "Brak znalezionych produkt??w",
                            text:
                                "\tNie znaleziono ??adnych produkt??w pasuj??cych do twoich preferencji. Spr??buj zmieni?? opcje filtrowania lub fraz?? wyszukiwania.",
                          ),
                        );
                      } else {
                        return SliverToBoxAdapter(
                          child: PageAlert(
                            leadingIconData: Icons.folder_off_rounded,
                            title: "Brak produkt??w",
                            text:
                                "\tPo dodaniu produkt??w do sesji, ich podgl??d bedzie znajdowa?? si?? tutaj. Z tego ekranu mo??esz je ??atwo usuwa??, dodawa?? lub edytowa?? ich w??a??ciwo??ci.",
                            buttons: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  //TODO przycisk z dodawaniem produkt??w
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Dodaj produkt"),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  }()
                ],
              ),
            );
          }
          return Column(
            children: [
              SafeArea(
                child: AppBar(
                  title: const Text("Produkty"),
                ),
              ),
              PageAlert(
                leadingIconData: Icons.folder_off_rounded,
                title: "Brak aktywnej sesji",
                text:
                    "\tPrzywr???? poprzednio utworzon?? sesj?? lub utw??rz now??, do kt??rej mo??esz doda?? produkty lub zaimportuj je z obs??ugiwanych plik??w.",
                buttons: [
                  ElevatedButton.icon(
                    onPressed: () {
                      context.router.push(const SessionsRouter());
                    },
                    icon: const Icon(Icons.folder_copy),
                    label: const Text("Poka?? sesje u??ytkownika"),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
