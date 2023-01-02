part of 'products_bloc.dart';

enum ProductsStatus { initial, loading, success, failure }

class ProductsState extends Equatable {
  final ProductsStatus status;
  final List<Product> products;
  final ProductsFilter filter;
  final String query;

  const ProductsState({
    this.status = ProductsStatus.initial,
    this.products = const [],
    this.filter = const ProductsFilter(),
    this.query = "",
  });

  @override
  List<Object?> get props => [status, products, filter, query];

  @override
  String toString() {
    return 'ProductsState(status: $status, products: $products, filter: $filter, query: $query)';
  }

  ProductsState copyWith({
    ProductsStatus Function()? status,
    List<Product> Function()? products,
    ProductsFilter Function()? filter,
    String Function()? query,
  }) {
    return ProductsState(
      status: status != null ? status() : this.status,
      products: products != null ? products() : this.products,
      filter: filter != null ? filter() : this.filter,
      query: query != null ? query() : this.query,
    );
  }
}
