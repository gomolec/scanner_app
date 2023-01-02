part of 'product_bloc.dart';

enum ProductStatus { initial, loading, success, failure }

class ProductState extends Equatable {
  final ProductStatus status;
  final Product? initialProduct;
  final String name;
  final String code;
  final int quantity;
  final int targetQuantity;
  final bool marked;
  final String note;
  final bool didChanged;

  const ProductState({
    this.status = ProductStatus.initial,
    this.initialProduct,
    this.name = "",
    this.code = "",
    this.quantity = 0,
    this.targetQuantity = 0,
    this.marked = false,
    this.note = "",
    this.didChanged = false,
  });

  @override
  List<Object?> get props {
    return [
      status,
      initialProduct,
      name,
      code,
      quantity,
      targetQuantity,
      marked,
      note,
      didChanged,
    ];
  }

  @override
  String toString() {
    return 'ProductState(status: $status, initialProduct: $initialProduct, name: $name, code: $code, quantity: $quantity, targetQuantity: $targetQuantity, marked: $marked, note: $note, didChanged: $didChanged)';
  }

  ProductState copyWith({
    ProductStatus? status,
    Product? initialProduct,
    String? name,
    String? code,
    int? quantity,
    int? targetQuantity,
    bool? marked,
    String? note,
    bool? didChanged,
  }) {
    return ProductState(
      status: status ?? this.status,
      initialProduct: initialProduct ?? this.initialProduct,
      name: name ?? this.name,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      marked: marked ?? this.marked,
      note: note ?? this.note,
      didChanged: didChanged ?? this.didChanged,
    );
  }
}
