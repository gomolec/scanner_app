import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scanner_app/pages/products_page/models/models.dart';
import 'package:scanner_app/repositories/products_repository.dart';

import '../../../../models/models.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  ProductsBloc({
    required ProductsRepository productsRepository,
  })  : _productsRepository = productsRepository,
        super(const ProductsState()) {
    on<ProductsSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductCreated>(_onProductCreated);
    on<ProductDeleted>(_onProductDeleted);
    on<ProductMarkingToggled>(_onProductMarkingToggled);
    on<ProductsApplyFilter>(_onProductsApplyFilter);
    on<ProductsQueried>(_onProductsQueried);
  }

  final ProductsRepository _productsRepository;
  final ProductsQuerier _querier = ProductsQuerier();
  final ProductsSorter _sorter = ProductsSorter();

  List<Product> _products = [];

  List<Product> filtrProducts({
    required List<Product> products,
    required String query,
    required ProductsFilter filter,
  }) {
    return _sorter
        .sortProducts(
            products: _querier.query(products.toList(), query), filter: filter)
        .toList();
  }

  Future<void> _onSubscriptionRequested(
    ProductsSubscriptionRequested event,
    Emitter<ProductsState> emit,
  ) async {
    if (_productsRepository.isSessionOpened) {
      emit(state.copyWith(status: () => ProductsStatus.loading));
    }

    await emit.forEach<List<Product>>(
      _productsRepository.stream,
      onData: (data) {
        _products = data.toList();
        if (data.isEmpty && !_productsRepository.isSessionOpened) {
          return state.copyWith(
            status: () => ProductsStatus.initial,
            products: () => _products,
            filter: () => const ProductsFilter(),
            query: () => "",
          );
        }
        return state.copyWith(
          status: () => ProductsStatus.success,
          products: () => filtrProducts(
            products: _products,
            query: state.query,
            filter: state.filter,
          ),
        );
      },
      onError: (_, __) {
        return state.copyWith(
          status: () => ProductsStatus.failure,
        );
      },
    );
  }

  void _onProductCreated(
    ProductCreated event,
    Emitter<ProductsState> emit,
  ) {
    _productsRepository.addProduct(event.product);
  }

  void _onProductDeleted(
    ProductDeleted event,
    Emitter<ProductsState> emit,
  ) {
    _productsRepository.deleteProduct(event.product.id);
  }

  void _onProductMarkingToggled(
    ProductMarkingToggled event,
    Emitter<ProductsState> emit,
  ) {
    _productsRepository.updateProduct(
      event.product.copyWith(
        marked: !event.product.marked,
      ),
      changeUpdated: false,
    );
  }

  void _onProductsApplyFilter(
    ProductsApplyFilter event,
    Emitter<ProductsState> emit,
  ) {
    emit(
      state.copyWith(
        products: () => filtrProducts(
          products: _products,
          query: state.query,
          filter: event.filter,
        ).toList(),
        filter: () => event.filter,
      ),
    );
  }

  void _onProductsQueried(
    ProductsQueried event,
    Emitter<ProductsState> emit,
  ) {
    emit(
      state.copyWith(
        products: () => filtrProducts(
          products: _products,
          query: event.query,
          filter: state.filter,
        ).toList(),
        query: () => event.query,
      ),
    );
  }
}
