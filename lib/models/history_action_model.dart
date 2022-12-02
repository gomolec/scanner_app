import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

import 'package:scanner_app/models/product_model.dart';

part 'history_action_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 3)
class HistoryAction extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final Product? oldProduct;
  @HiveField(2)
  final Product? updatedProduct;
  @HiveField(3)
  final bool isRedo;

  const HistoryAction({
    required this.id,
    this.oldProduct,
    this.updatedProduct,
    this.isRedo = false,
  });

  HistoryAction copyWith({
    int? id,
    Product? Function()? oldProduct,
    Product? Function()? updatedProduct,
    bool? isRedo,
  }) {
    return HistoryAction(
      id: id ?? this.id,
      oldProduct: oldProduct != null ? oldProduct() : this.oldProduct,
      updatedProduct:
          updatedProduct != null ? updatedProduct() : this.updatedProduct,
      isRedo: isRedo ?? this.isRedo,
    );
  }

  factory HistoryAction.fromJson(Map<String, dynamic> json) =>
      _$HistoryActionFromJson(json);

  Map<String, dynamic> toJson() => _$HistoryActionToJson(this);

  @override
  String toString() {
    return 'HistoryAction(id: $id, oldProduct: $oldProduct, updatedProduct: $updatedProduct, isRedo: $isRedo)';
  }

  @override
  List<Object?> get props => [id, oldProduct, updatedProduct, isRedo];
}
