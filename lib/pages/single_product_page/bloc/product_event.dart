part of 'product_bloc.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();

  @override
  List<Object> get props => [];
}

class ProductSubscriptionRequested extends ProductEvent {
  const ProductSubscriptionRequested();
}

class ProductQuantityChanged extends ProductEvent {
  const ProductQuantityChanged(this.quantity);

  final int quantity;

  @override
  List<Object> get props => [quantity];
}

class ProductTargetQuantityChanged extends ProductEvent {
  const ProductTargetQuantityChanged(this.targetQuantity);

  final int targetQuantity;

  @override
  List<Object> get props => [targetQuantity];
}

class ProductNameChanged extends ProductEvent {
  const ProductNameChanged(this.name);

  final String name;

  @override
  List<Object> get props => [name];
}

class ProductCodeChanged extends ProductEvent {
  const ProductCodeChanged(this.code);

  final String code;

  @override
  List<Object> get props => [code];
}

class ProductNoteChanged extends ProductEvent {
  const ProductNoteChanged(this.note);

  final String note;

  @override
  List<Object> get props => [note];
}

class ProductChangesSaved extends ProductEvent {
  const ProductChangesSaved();
}

class ProductMarkedChanged extends ProductEvent {
  const ProductMarkedChanged(this.marked);

  final bool marked;

  @override
  List<Object> get props => [marked];
}

class ProductDeleted extends ProductEvent {
  const ProductDeleted();
}
