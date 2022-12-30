import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../cubits/cubits.dart';
import '../../models/models.dart';
import '../../widgets/widgets.dart';
import 'widgets/transparent_scroll_appbar.dart';

class SingleProductPage extends StatefulWidget {
  final int productId;

  const SingleProductPage({
    Key? key,
    @PathParam() required this.productId,
  }) : super(key: key);

  static final ScrollController controller = ScrollController();

  @override
  State<SingleProductPage> createState() => _SingleProductPageState();
}

class _SingleProductPageState extends State<SingleProductPage> {
  @override
  Widget build(BuildContext context) {
    Product? product =
        context.read<ProductsCubit>().getProduct(widget.productId);
    if (product != null) {
      return Scaffold(
        appBar: TransparentScrollAppBar(
          backgroundColor: Theme.of(context).colorScheme.surface,
          controller: SingleProductPage.controller,
          leading: const AutoLeadingButton(),
          actions: [
            IconToggleButton(
              icon: const Icon(Icons.flag_outlined),
              selectedIcon: const Icon(Icons.flag),
              isSelected: product!.marked,
              selectedColor: Theme.of(context).colorScheme.error,
              onPressed: () {
                product = product!.copyWith(marked: !product!.marked);
                context.read<ProductsCubit>().toggleIsPinned(widget.productId);
              },
            ),
            IconButton(
              onPressed: () {},
              tooltip: "Więcej opcji",
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(
          controller: SingleProductPage.controller,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Material(
                color: Theme.of(context).colorScheme.surface,
                surfaceTintColor: Theme.of(context).colorScheme.surfaceTint,
                elevation: 2.0,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product!.name,
                      style: Theme.of(context)
                          .textTheme
                          .headlineMedium
                          ?.copyWith(
                              color:
                                  Theme.of(context).colorScheme.onBackground),
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 16.0,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Kod produktu",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                              ),
                              Text(
                                product!.code,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Ostatnia aktualizacja",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                              ),
                              Text(
                                DateFormat("dd.MM.yyyy HH:mm")
                                    .format(product!.updated),
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          Text(
                            "USTAW ILOŚĆ",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant,
                                ),
                          ),
                          const SizedBox(height: 8.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.remove_rounded,
                                  size: 64.0,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              ),
                              Text(
                                " 0 / 10",
                                style: Theme.of(context)
                                    .textTheme
                                    .headlineMedium
                                    ?.copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onBackground),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: Icon(
                                  Icons.add_rounded,
                                  size: 64.0,
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 16.0,
                    ),
                    Text(
                      "Notatki",
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color:
                              Theme.of(context).colorScheme.onSurfaceVariant),
                    ),
                    Text(
                      product!.note,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    const Divider(
                      thickness: 1.0,
                      height: 16.0,
                    ),
                    Center(
                      child: TextButton.icon(
                        onPressed: () {},
                        icon: const Icon(Icons.link_rounded),
                        label: const Text("Strona internetowa produktu"),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
    return Scaffold(
      appBar: AppBar(
        leading: const AutoLeadingButton(),
      ),
      body: PageAlert(
        leadingIconData: Icons.error_outline_rounded,
        title: "Nie znaleziono produktu",
        text:
            "Wystąpił problem podczas wyświetlania danych o produkcie z przypisanym id: ${widget.productId}.",
      ),
    );
  }
}
