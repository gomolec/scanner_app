import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:scanner_app/models/models.dart';
import 'package:scanner_app/repositories/repositories.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc({
    required ProductsRepository productsRepository,
    required int? initialProductId,
  })  : _productsRepository = productsRepository,
        _initialProduct = initialProductId != null
            ? productsRepository.findById(initialProductId)
            : null,
        super(const ProductState(status: ProductStatus.loading)) {
    on<ProductSubscriptionRequested>(_onSubscriptionRequested);
    on<ProductQuantityChanged>(_onQuantityChanged);
    on<ProductTargetQuantityChanged>(_onTargetQuantityChanged);
    on<ProductNameChanged>(_onNameChanged);
    on<ProductCodeChanged>(_onCodeChanged);
    on<ProductNoteChanged>(_onNoteChanged);
    on<ProductChangesSaved>(_onChangesSaved);
    on<ProductMarkedChanged>(_onMarkedChanged);
    on<ProductDeleted>(_onDeleted);
  }

  final ProductsRepository _productsRepository;
  final Product? _initialProduct;

  void _onSubscriptionRequested(
    ProductSubscriptionRequested event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      status: ProductStatus.initial,
      initialProduct: _initialProduct,
      name: _initialProduct?.name ?? '',
      code: _initialProduct?.code ?? '',
      quantity: _initialProduct?.quantity ?? 0,
      targetQuantity: _initialProduct?.targetQuantity ?? 0,
      marked: _initialProduct?.marked ?? false,
      note: _initialProduct?.note ?? '',
    ));
  }

  void _onQuantityChanged(
    ProductQuantityChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      quantity: event.quantity,
      didChanged: true,
    ));
  }

  void _onTargetQuantityChanged(
    ProductTargetQuantityChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      targetQuantity: event.targetQuantity,
      didChanged: true,
    ));
  }

  void _onNameChanged(
    ProductNameChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      name: event.name,
      didChanged: true,
    ));
  }

  void _onCodeChanged(
    ProductCodeChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      code: event.code,
      didChanged: true,
    ));
  }

  void _onNoteChanged(
    ProductNoteChanged event,
    Emitter<ProductState> emit,
  ) {
    emit(state.copyWith(
      note: event.note,
      didChanged: true,
    ));
  }

  void _onChangesSaved(
    ProductChangesSaved event,
    Emitter<ProductState> emit,
  ) {
    final Product newProduct = (state.initialProduct ??
            Product(
              created: DateTime.now(),
              updated: DateTime.now(),
            ))
        .copyWith(
      name: state.name,
      code: state.code,
      note: state.note,
      quantity: state.quantity,
      targetQuantity: state.targetQuantity,
      marked: state.marked,
    );

    emit(const ProductState(status: ProductStatus.loading));

    try {
      _productsRepository.updateProduct(newProduct);
      emit(state.copyWith(
        status: ProductStatus.initial,
        initialProduct: newProduct,
        name: newProduct.name,
        code: newProduct.code,
        quantity: newProduct.quantity,
        targetQuantity: newProduct.targetQuantity,
        marked: newProduct.marked,
        note: newProduct.note,
      ));
    } catch (e) {
      emit(state.copyWith(
        status: ProductStatus.failure,
      ));
    }
  }

  void _onMarkedChanged(
    ProductMarkedChanged event,
    Emitter<ProductState> emit,
  ) {
    if (state.initialProduct != null) {
      try {
        _productsRepository.updateProduct(
          state.initialProduct!.copyWith(marked: event.marked),
          changeUpdated: false,
        );

        emit(state.copyWith(
          marked: event.marked,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ProductStatus.failure,
        ));
      }
    } else {
      emit(state.copyWith(
        marked: event.marked,
      ));
    }
  }

  void _onDeleted(
    ProductDeleted event,
    Emitter<ProductState> emit,
  ) {
    if (state.initialProduct != null) {
      try {
        _productsRepository.deleteProduct(_initialProduct!.id);
        emit(state.copyWith(
          status: ProductStatus.success,
        ));
      } catch (e) {
        emit(state.copyWith(
          status: ProductStatus.failure,
        ));
      }
    } else {
      emit(state.copyWith(
        status: ProductStatus.success,
      ));
    }
  }
}
