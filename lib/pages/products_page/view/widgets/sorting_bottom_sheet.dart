import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scanner_app/pages/products_page/bloc/products_filter_bloc/products_filter_bloc.dart';

import 'package:scanner_app/pages/products_page/models/models.dart';

class SortingBottomSheet extends StatelessWidget {
  final ProductsFilter initialFilter;

  const SortingBottomSheet({
    Key? key,
    required this.initialFilter,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => ProductsFilterBloc(
        initialFilter: initialFilter,
      ),
      child: const SortingBottomSheetView(),
    );
  }
}

class SortingBottomSheetView extends StatelessWidget {
  const SortingBottomSheetView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsFilterBloc, ProductsFilterState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                  top: 22.0,
                  bottom: 8.0,
                ),
                child: Container(
                  width: 32.0,
                  height: 4.0,
                  decoration: BoxDecoration(
                    color: Theme.of(context)
                        .colorScheme
                        .onSurfaceVariant
                        .withOpacity(0.4),
                    borderRadius: BorderRadius.circular(2.0),
                  ),
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        TextButton(
                          onPressed: !state.filter.isDefault
                              ? () {
                                  context
                                      .read<ProductsFilterBloc>()
                                      .add(const FilterReset());
                                }
                              : null,
                          child: const Text("Resetuj"),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Filtrowanie',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: state.filter != state.initialFilter
                              ? () {
                                  Navigator.pop(context, state.filter);
                                }
                              : null,
                          child: const Text("Zastosuj"),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Widok",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8.0),
                  _DialogViewTile(
                    title: "Lista",
                    leadingIcon: Icons.list_rounded,
                    selected: state.filter.view == ProductsView.list,
                    onTab: () {
                      context
                          .read<ProductsFilterBloc>()
                          .add(const FilterChangeView(ProductsView.list));
                    },
                  ),
                  _DialogViewTile(
                    title: "Siatka",
                    leadingIcon: Icons.grid_on_rounded,
                    selected: state.filter.view == ProductsView.grid,
                    onTab: () {
                      context
                          .read<ProductsFilterBloc>()
                          .add(const FilterChangeView(ProductsView.grid));
                    },
                  ),
                  const Divider(
                    height: 16.0,
                    thickness: 1.0,
                  ),
                  Text(
                    "Opcje widoku",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8.0),
                  _DialogViewOptionTile(
                    title: "Poka?? kompletne",
                    leadingIcon: Icons.visibility_off_rounded,
                    selected: state.filter.showCompleted,
                    onChanged: (bool? newValue) {
                      if (newValue != null) {
                        context
                            .read<ProductsFilterBloc>()
                            .add(FilterShowCompleted(newValue));
                      }
                    },
                  ),
                  _DialogViewOptionTile(
                    title: "Poka?? oflagowane",
                    leadingIcon: Icons.flag_rounded,
                    selected: state.filter.showMarked,
                    onChanged: (bool? newValue) {
                      if (newValue != null) {
                        context
                            .read<ProductsFilterBloc>()
                            .add(FilterShowMarked(newValue));
                      }
                    },
                  ),
                  const Divider(
                    height: 16.0,
                    thickness: 1.0,
                  ),
                  Text(
                    "Sortuj wed??ug",
                    style: Theme.of(context).textTheme.titleSmall,
                  ),
                  const SizedBox(height: 8.0),
                  _DialogSortingTile(
                    title: "Nazwa",
                    selected: state.filter.sorting == ProductsSorting.name,
                    ascending: state.filter.ascendingSorting,
                    onTab: () {
                      context
                          .read<ProductsFilterBloc>()
                          .add(const FilterChangeSorting(ProductsSorting.name));
                    },
                    onChanged: (bool? newValue) {
                      context.read<ProductsFilterBloc>().add(
                            FilterChangeSorting(
                              ProductsSorting.name,
                              ascending: newValue,
                            ),
                          );
                    },
                  ),
                  _DialogSortingTile(
                    title: "Ostatnia aktualizacja",
                    selected: state.filter.sorting == ProductsSorting.update,
                    ascending: state.filter.ascendingSorting,
                    onTab: () {
                      context.read<ProductsFilterBloc>().add(
                          const FilterChangeSorting(ProductsSorting.update));
                    },
                    onChanged: (bool? newValue) {
                      context.read<ProductsFilterBloc>().add(
                            FilterChangeSorting(
                              ProductsSorting.update,
                              ascending: newValue,
                            ),
                          );
                    },
                  ),
                  _DialogSortingTile(
                    title: "Ilo????",
                    selected: state.filter.sorting == ProductsSorting.quantity,
                    ascending: state.filter.ascendingSorting,
                    onTab: () {
                      context.read<ProductsFilterBloc>().add(
                            const FilterChangeSorting(ProductsSorting.quantity),
                          );
                    },
                    onChanged: (bool? newValue) {
                      context.read<ProductsFilterBloc>().add(
                            FilterChangeSorting(
                              ProductsSorting.quantity,
                              ascending: newValue,
                            ),
                          );
                    },
                  ),
                  const SizedBox(height: 8.0),
                ],
              )
            ],
          ),
        );
      },
    );
  }
}

class _DialogViewTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final bool selected;
  final void Function() onTab;
  const _DialogViewTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.selected,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onBackground;

    return GestureDetector(
      onTap: onTab,
      child: SizedBox(
        height: 40.0,
        child: Row(
          children: [
            Icon(
              leadingIcon,
              size: 24.0,
              color: color,
            ),
            const SizedBox(width: 16.0),
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: color),
              ),
            ),
            selected
                ? Icon(
                    Icons.done_rounded,
                    size: 24.0,
                    color: color,
                  )
                : const SizedBox(),
            const SizedBox(width: 8.0),
          ],
        ),
      ),
    );
  }
}

class _DialogViewOptionTile extends StatelessWidget {
  final IconData leadingIcon;
  final String title;
  final bool selected;
  final void Function(bool?) onChanged;

  const _DialogViewOptionTile({
    Key? key,
    required this.leadingIcon,
    required this.title,
    required this.selected,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Theme.of(context).colorScheme.onBackground;

    return SizedBox(
      height: 40.0,
      child: Row(
        children: [
          Icon(
            leadingIcon,
            size: 24.0,
            color: color,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              title,
              style:
                  Theme.of(context).textTheme.bodyLarge!.copyWith(color: color),
            ),
          ),
          SizedBox(
            width: 24.0,
            child: Switch(
              value: selected,
              onChanged: onChanged,
              activeColor: Theme.of(context).colorScheme.primary,
              materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
          const SizedBox(width: 8.0),
        ],
      ),
    );
  }
}

class _DialogSortingTile extends StatelessWidget {
  final String title;
  final bool selected;
  final bool ascending;
  final void Function() onTab;
  final void Function(bool?) onChanged;
  const _DialogSortingTile({
    Key? key,
    required this.title,
    required this.selected,
    this.ascending = false,
    required this.onTab,
    required this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = selected
        ? Theme.of(context).colorScheme.primary
        : Theme.of(context).colorScheme.onBackground;

    return GestureDetector(
      onTap: onTab,
      child: SizedBox(
        height: 36.0,
        child: Row(
          children: [
            Expanded(
              child: Text(
                title,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge!
                    .copyWith(color: color),
              ),
            ),
            selected
                ? SizedBox(
                    width: 24.0,
                    child: IconButton(
                      icon: Transform(
                        alignment: Alignment.center,
                        transform: Matrix4.rotationX(ascending ? math.pi : 0),
                        child: Icon(
                          Icons.sort_rounded,
                          size: 24.0,
                          color: color,
                        ),
                      ),
                      onPressed: () {
                        onChanged(!ascending);
                      },
                    ),
                  )
                : const SizedBox(),
            const SizedBox(width: 16.0),
          ],
        ),
      ),
    );
  }
}
