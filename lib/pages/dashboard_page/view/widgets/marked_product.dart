import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../routes/router.gr.dart';
import '../../../../theme/theme.dart';

class MarkedProductsCard extends StatelessWidget {
  final Product product;

  const MarkedProductsCard({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      margin: EdgeInsets.zero,
      color: Theme.of(context).colorScheme.surfaceVariant,
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: () {
          context.router
              .push(SingleProductRouter(initialProductId: product.id));
        },
        child: SizedBox(
          width: 152.0,
          height: 204.0,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              () {
                late final Color color;
                late final Color iconColor;
                if (product.marked) {
                  color = Theme.of(context).colorScheme.errorContainer;
                  iconColor = Theme.of(context).colorScheme.onErrorContainer;
                } else {
                  if (product.quantity == product.targetQuantity) {
                    color = Theme.of(context)
                        .extension<CustomColors>()!
                        .successContainer!;
                    iconColor = Theme.of(context)
                        .extension<CustomColors>()!
                        .onSuccessContainer!;
                  } else if (product.quantity == 0) {
                    color = Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.12);
                    iconColor = Theme.of(context)
                        .colorScheme
                        .onSurface
                        .withOpacity(0.76);
                  } else {
                    color = Theme.of(context)
                        .extension<CustomColors>()!
                        .warningContainer!;
                    iconColor = Theme.of(context)
                        .extension<CustomColors>()!
                        .onWarningContainer!;
                  }
                }
                return Container(
                  width: 152.0,
                  height: 152.0,
                  decoration: BoxDecoration(
                    color: color,
                    borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                  ),
                  child: Icon(
                    product.marked
                        ? Icons.flag_outlined
                        : Icons.inventory_2_outlined,
                    size: 56.0,
                    color: iconColor,
                  ),
                );
              }(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    Text(
                      product.code,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.caption,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
