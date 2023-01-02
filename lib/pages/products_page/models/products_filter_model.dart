import 'package:equatable/equatable.dart';

enum ProductsView { grid, list }

enum ProductsSorting { name, update, quantity }

class ProductsFilter extends Equatable {
  final ProductsView view;
  final ProductsSorting sorting;
  final bool showCompleted;
  final bool showMarked;
  final bool ascendingSorting;
  final bool isDefault;

  const ProductsFilter({
    this.view = ProductsView.list,
    this.sorting = ProductsSorting.name,
    this.showCompleted = true,
    this.showMarked = true,
    this.ascendingSorting = true,
    this.isDefault = true,
  });

  @override
  List<Object> get props {
    return [
      view,
      sorting,
      showCompleted,
      showMarked,
      ascendingSorting,
      isDefault
    ];
  }

  ProductsFilter copyWith(
      {ProductsView? view,
      ProductsSorting? sorting,
      bool? showCompleted,
      bool? showMarked,
      bool? ascendingSorting,
      bool? isDefault}) {
    return ProductsFilter(
      view: view ?? this.view,
      sorting: sorting ?? this.sorting,
      showCompleted: showCompleted ?? this.showCompleted,
      showMarked: showMarked ?? this.showMarked,
      ascendingSorting: ascendingSorting ?? this.ascendingSorting,
      isDefault: isDefault ?? this.isDefault,
    );
  }

  @override
  String toString() {
    return 'ProductsFilter(view: $view, sorting: $sorting, showCompleted: $showCompleted, showMarked: $showMarked, ascendingSorting: $ascendingSorting, isDefault: $isDefault)';
  }
}
