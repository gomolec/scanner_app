import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/models/models.dart';
import '../../cubits/cubits.dart';
import '../../widgets/page_alert.dart';
import 'widgets/product_tile.dart';
import 'widgets/search_bar_button.dart';

class ProductsPage extends StatelessWidget {
  const ProductsPage({Key? key}) : super(key: key);

  static final ScrollController scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<ProductsCubit, ProductsState>(
        builder: (context, state) {
          if (state is ProductsLoaded) {
            return Scrollbar(
              controller: scrollController,
              interactive: true,
              child: CustomScrollView(
                controller: scrollController,
                slivers: <Widget>[
                  SliverAppBar.medium(
                    title: const Text("Produkty"),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        tooltip: "Zaznacz",
                        icon: const Icon(Icons.check_box_outlined),
                      ),
                      IconButton(
                        onPressed: () {},
                        tooltip: "Filtruj",
                        icon: const Icon(Icons.filter_alt_outlined),
                      ),
                      IconButton(
                        onPressed: () {
                          context.read<ProductsCubit>().addProduct(
                                Product(
                                  name: "TEST",
                                  code: "574589534",
                                  note:
                                      "Notateczkafhjdkjfhdjkfhdjkshfjksdhfkjhsdfjhsdjfhsdkjh",
                                  quantity: 40,
                                  targetQuantity: 10,
                                  created: DateTime.now(),
                                  updated: DateTime.now(),
                                ),
                              );
                        },
                        tooltip: "Nowy produkt",
                        icon: const Icon(Icons.add_rounded),
                      ),
                    ],
                  ),
                  SliverToBoxAdapter(
                    child: Column(
                      children: const [
                        SearchBarButton(),
                        Divider(
                          height: 8,
                          thickness: 1,
                        ),
                      ],
                    ),
                  ),
                  state.products.isNotEmpty
                      ? SliverList(
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
                        )
                      : SliverToBoxAdapter(
                          child: PageAlert(
                            leadingIconData: Icons.folder_off_rounded,
                            title: "Brak produktów",
                            text:
                                "\tPo dodaniu produktów do sesji, ich podgląd bedzie znajdować się tutaj. Z tego ekranu możesz je łatwo usuwać, dodawać lub edytować ich właściwości.",
                            buttons: [
                              ElevatedButton.icon(
                                onPressed: () {
                                  //TODO przycisk z dodawaniem produktów
                                },
                                icon: const Icon(Icons.add),
                                label: const Text("Dodaj produkt"),
                              ),
                            ],
                          ),
                        ),
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
                    "\tPrzywróć poprzednio utworzoną sesję lub utwórz nową, do której możesz dodać produkty lub zaimportuj je z obsługiwanych plików.",
                buttons: [
                  ElevatedButton.icon(
                    onPressed: () {
                      // context.navigateTo(
                      //   const MenuRouter(children: [SessionsRoute()]),
                      // );
                    },
                    icon: const Icon(Icons.folder_copy),
                    label: const Text("Pokaż sesje użytkownika"),
                  ),
                ],
              ),
            ],
          );
          ;
        },
      ),
    );
  }
}
