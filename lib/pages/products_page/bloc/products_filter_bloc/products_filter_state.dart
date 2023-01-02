part of 'products_filter_bloc.dart';

class ProductsFilterState extends Equatable {
  final ProductsFilter filter;
  final ProductsFilter initialFilter;

  const ProductsFilterState({
    this.filter = const ProductsFilter(),
    required this.initialFilter,
  });

  ProductsFilterState copyWith({
    ProductsFilter? filter,
    ProductsFilter? initialFilter,
  }) {
    return ProductsFilterState(
      filter: filter ?? this.filter,
      initialFilter: initialFilter ?? this.initialFilter,
    );
  }

  @override
  String toString() =>
      'ProductsFilterState(filter: $filter, initialFilter: $initialFilter)';

  @override
  List<Object> get props => [filter, initialFilter];
}
