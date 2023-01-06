import 'package:flutter/material.dart';

import '../../../../models/models.dart';
import '../../../../theme/theme.dart';

enum TileType { created, deleted, updated, none }

enum UpdateType { quantity, marking, none }

class HistoryActionTile extends StatelessWidget {
  final HistoryAction historyAction;

  const HistoryActionTile({
    Key? key,
    required this.historyAction,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    late final TileType type;
    UpdateType updateType = UpdateType.none;
    if (historyAction.oldProduct != null &&
        historyAction.updatedProduct != null) {
      type = TileType.updated;
      if (historyAction.oldProduct!.quantity !=
              historyAction.updatedProduct!.quantity ||
          historyAction.oldProduct!.targetQuantity !=
              historyAction.updatedProduct!.targetQuantity) {
        updateType = UpdateType.quantity;
      } else if (historyAction.oldProduct!.marked !=
          historyAction.updatedProduct!.marked) {
        updateType = UpdateType.marking;
      }
    } else if (historyAction.oldProduct != null) {
      type = TileType.deleted;
    } else if (historyAction.updatedProduct != null) {
      type = TileType.created;
    } else {
      type = TileType.none;
      return const SizedBox();
    }
    return InkWell(
      onTap: () {},
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(16.0, 12.0, 16.0, 12.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            () {
              late final IconData iconData;
              late final Color color;
              if (type == TileType.created) {
                iconData = Icons.add_rounded;
                color = Theme.of(context)
                    .extension<CustomColors>()!
                    .successContainer!;
              } else if (type == TileType.deleted) {
                iconData = Icons.delete_outline_rounded;
                color = Theme.of(context).colorScheme.errorContainer;
              } else {
                iconData = Icons.change_history_rounded;
                color = Theme.of(context)
                    .extension<CustomColors>()!
                    .warningContainer!;
              }
              return Container(
                width: 56.0,
                height: 56.0,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: const BorderRadius.all(Radius.circular(8.0)),
                ),
                child: Icon(
                  iconData,
                ),
              );
            }(),
            const SizedBox(width: 16.0),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    () {
                      if (type == TileType.created) {
                        return "Dodano nowy produkt";
                      } else if (type == TileType.deleted) {
                        return "Usunięto produkt";
                      } else {
                        return "Zaaktualizowano produkt";
                      }
                    }(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    type == TileType.deleted
                        ? historyAction.oldProduct!.name
                        : historyAction.updatedProduct!.name,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 2.0),
                    child: Row(
                      children: [
                        const Icon(
                          Icons.layers_outlined,
                          size: 16.0,
                        ),
                        const SizedBox(width: 2.0),
                        RichText(
                          text: TextSpan(
                            style: Theme.of(context).textTheme.bodySmall,
                            children: [
                              TextSpan(
                                text: (type == TileType.deleted)
                                    ? "${historyAction.oldProduct!.quantity} z ${historyAction.oldProduct!.targetQuantity} szt"
                                    : "${historyAction.updatedProduct!.quantity} z ${historyAction.updatedProduct!.targetQuantity} szt",
                              ),
                              (type == TileType.updated)
                                  ? TextSpan(
                                      text:
                                          " (${historyAction.oldProduct!.quantity} z ${historyAction.oldProduct!.targetQuantity} szt)",
                                      style: const TextStyle(
                                        decoration: TextDecoration.lineThrough,
                                      ),
                                    )
                                  : const TextSpan(),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 16.0),
            type == TileType.updated
                ? Container(
                    height: 56.0,
                    alignment: Alignment.center,
                    child: (updateType != UpdateType.none)
                        ? (updateType == UpdateType.quantity)
                            ? Text(
                                () {
                                  String trailingText =
                                      "${historyAction.updatedProduct!.quantity - historyAction.oldProduct!.quantity}";
                                  if (int.parse(trailingText) > 0) {
                                    trailingText = "+$trailingText";
                                  }
                                  return trailingText;
                                }(),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(
                                        color: Theme.of(context)
                                            .colorScheme
                                            .onSurfaceVariant),
                              )
                            : Icon(
                                Icons.flag_rounded,
                                size: 20.0,
                                color: Theme.of(context)
                                    .colorScheme
                                    .onSurfaceVariant,
                              )
                        : const SizedBox(),
                  )
                : const SizedBox(),
          ],
        ),
      ),
    );
  }
}
