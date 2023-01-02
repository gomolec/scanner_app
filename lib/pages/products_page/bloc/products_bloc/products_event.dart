part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object?> get props => [];
}

class ProductsSubscriptionRequested extends ProductsEvent {
  const ProductsSubscriptionRequested();
}

class ProductCreated extends ProductsEvent {
  final Product product;

  const ProductCreated({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ProductDeleted extends ProductsEvent {
  final Product product;

  const ProductDeleted({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ProductMarkingToggled extends ProductsEvent {
  final Product product;

  const ProductMarkingToggled({
    required this.product,
  });

  @override
  List<Object> get props => [product];
}

class ProductsApplyFilter extends ProductsEvent {
  final ProductsFilter filter;

  const ProductsApplyFilter(
    this.filter,
  );

  @override
  List<Object> get props => [filter];
}

class ProductsQueried extends ProductsEvent {
  final String query;

  const ProductsQueried(
    this.query,
  );

  @override
  List<Object> get props => [query];
}
