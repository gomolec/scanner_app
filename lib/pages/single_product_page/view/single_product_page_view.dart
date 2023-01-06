import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:scanner_app/pages/single_product_page/bloc/product_bloc.dart';
import 'package:scanner_app/pages/single_product_page/view/widgets/widgets.dart';
import '../../../repositories/repositories.dart';

class SingleProductPage extends StatelessWidget {
  final int? initialProductId;
  const SingleProductPage({
    Key? key,
    @PathParam() this.initialProductId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductBloc(
        productsRepository: context.read<ProductsRepository>(),
        productsHistoryRepository: context.read<ProductsHistoryRepository>(),
        initialProductId: initialProductId,
      )..add(const ProductSubscriptionRequested()),
      child: const SingleProductPageView(),
    );
  }
}

class SingleProductPageView extends StatelessWidget {
  const SingleProductPageView({Key? key}) : super(key: key);

  static final ScrollController controller = ScrollController();

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state.status == ProductStatus.success) {
          context.router.pop();
        }
      },
      child: BlocBuilder<ProductBloc, ProductState>(
        builder: (context, state) {
          if (state.status == ProductStatus.initial) {
            return Scaffold(
              appBar: ProductAppBar(
                marked: state.marked,
                backgroundColor: Theme.of(context).colorScheme.surface,
                controller: SingleProductPageView.controller,
              ),
              extendBodyBehindAppBar:
                  state.initialProduct != null ? true : false,
              body: SingleChildScrollView(
                controller: SingleProductPageView.controller,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.initialProduct != null
                        ? Material(
                            color: Theme.of(context).colorScheme.surface,
                            surfaceTintColor:
                                Theme.of(context).colorScheme.surfaceTint,
                            elevation: 2.0,
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.width,
                            ),
                          )
                        : const SizedBox(),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const ProductNameField(),
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
                                    const ProductCodeField()
                                  ],
                                ),
                              ),
                              state.initialProduct != null
                                  ? Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
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
                                                .format(state
                                                    .initialProduct!.updated),
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                          ),
                                        ],
                                      ),
                                    )
                                  : const SizedBox(),
                            ],
                          ),
                          const Divider(
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          QuantityButtons(
                            initialQuantity: state.quantity,
                            initialTargetQuantity: state.targetQuantity,
                          ),
                          const Divider(
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          Text(
                            "Notatki",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant),
                          ),
                          const ProductNoteField(),
                          const Divider(
                            thickness: 1.0,
                            height: 16.0,
                          ),
                          state.initialProduct != null
                              ? Center(
                                  child: TextButton.icon(
                                    onPressed:
                                        state.initialProduct!.url.isNotEmpty
                                            ? () {}
                                            : null,
                                    icon: const Icon(Icons.link_rounded),
                                    label: const Text(
                                        "Strona internetowa produktu"),
                                  ),
                                )
                              : const SizedBox(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

class ProductNameField extends StatelessWidget {
  const ProductNameField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.name,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductNameChanged(value)),
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text("Nazwa produktu"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context)
          .textTheme
          .headlineMedium
          ?.copyWith(color: Theme.of(context).colorScheme.onBackground),
    );
  }
}

class ProductCodeField extends StatelessWidget {
  const ProductCodeField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.code,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductCodeChanged(value)),
      textInputAction: TextInputAction.done,
      decoration: const InputDecoration(
        label: Text("np. 007"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}

class ProductNoteField extends StatelessWidget {
  const ProductNoteField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final state = context.watch<ProductBloc>().state;
    return TextFormField(
      initialValue: state.note,
      onChanged: (value) =>
          context.read<ProductBloc>().add(ProductNoteChanged(value)),
      decoration: const InputDecoration(
        label: Text("Zapisz tu przydatne informacje"),
        floatingLabelBehavior: FloatingLabelBehavior.never,
        border: InputBorder.none,
        isCollapsed: true,
      ),
      maxLines: null,
      style: Theme.of(context).textTheme.bodyMedium,
    );
  }
}
