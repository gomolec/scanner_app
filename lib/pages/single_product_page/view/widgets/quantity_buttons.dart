import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../bloc/product_bloc.dart';

class QuantityButtons extends StatefulWidget {
  const QuantityButtons({
    Key? key,
    this.initialQuantity = 0,
    this.initialTargetQuantity = 0,
  }) : super(key: key);

  final int initialQuantity;
  final int initialTargetQuantity;

  @override
  State<QuantityButtons> createState() => _QuantityButtonsState();
}

class _QuantityButtonsState extends State<QuantityButtons> {
  late final TextEditingController _quantityController;
  late final TextEditingController _targetQuantityController;

  int quantity = 0;
  int targetQuantity = 0;

  @override
  void initState() {
    quantity = widget.initialQuantity;
    targetQuantity = widget.initialTargetQuantity;
    _quantityController = TextEditingController(text: quantity.toString());
    _targetQuantityController =
        TextEditingController(text: targetQuantity.toString());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProductBloc, ProductState>(
      listenWhen: (previous, current) {
        if (previous.quantity != current.quantity) {
          return true;
        }
        if (previous.targetQuantity != current.targetQuantity) {
          return true;
        }
        return false;
      },
      listener: (context, state) {
        bool didUpdate = false;
        if (quantity != state.quantity) {
          quantity = state.quantity;
          _quantityController.text = quantity.toString();
          didUpdate = true;
        }

        if (targetQuantity != state.targetQuantity) {
          targetQuantity = state.targetQuantity;
          _targetQuantityController.text = targetQuantity.toString();
          didUpdate = true;
        }

        if (didUpdate) {
          setState(() {});
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Column(
          children: [
            Text(
              "USTAW ILOŚĆ",
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
            ),
            const SizedBox(height: 8.0),
            Row(
              children: [
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32.0),
                    onTap: quantity >= 1
                        ? () {
                            context
                                .read<ProductBloc>()
                                .add(ProductQuantityChanged(quantity - 1));
                          }
                        : null,
                    onLongPress: quantity >= 1
                        ? () {
                            context
                                .read<ProductBloc>()
                                .add(const ProductQuantityChanged(0));
                          }
                        : null,
                    child: Icon(
                      Icons.remove_rounded,
                      size: 64.0,
                      color: quantity >= 1
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context)
                              .colorScheme
                              .onSurface
                              .withOpacity(0.38),
                    ),
                  ),
                ),
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              int? newQuantity = int.tryParse(value);
                              if (newQuantity != null) {
                                setState(() {
                                  quantity = newQuantity;
                                });
                                context
                                    .read<ProductBloc>()
                                    .add(ProductQuantityChanged(newQuantity));
                              }
                            }
                          },
                          controller: _quantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onSurfaceVariant
                                      .withOpacity(0.8)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text(
                          "/",
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            if (value.isNotEmpty) {
                              int? newTargetQuantity = int.tryParse(value);
                              if (newTargetQuantity != null) {
                                setState(() {
                                  targetQuantity = newTargetQuantity;
                                });
                                context.read<ProductBloc>().add(
                                    ProductTargetQuantityChanged(
                                        targetQuantity));
                              }
                            }
                          },
                          controller: _targetQuantityController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                  color: Theme.of(context)
                                      .colorScheme
                                      .onBackground),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: InkWell(
                    borderRadius: BorderRadius.circular(32.0),
                    onTap: () {
                      context
                          .read<ProductBloc>()
                          .add(ProductQuantityChanged(quantity + 1));
                    },
                    onLongPress: () {
                      context
                          .read<ProductBloc>()
                          .add(ProductQuantityChanged(targetQuantity));
                    },
                    child: Icon(
                      Icons.add_rounded,
                      size: 64.0,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
