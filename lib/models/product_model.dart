import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'product_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 2)
class Product extends Equatable {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String code;
  @HiveField(3)
  final int quantity;
  @HiveField(4)
  final int targetQuantity;
  @HiveField(5)
  final DateTime created;
  @HiveField(6)
  final DateTime updated;
  @HiveField(7)
  final bool marked;
  @HiveField(8)
  final String note;
  @HiveField(9)
  final String imageUrl;
  @HiveField(10)
  final String url;

  const Product({
    this.id = 0,
    required this.name,
    required this.code,
    this.quantity = 0,
    required this.targetQuantity,
    required this.created,
    required this.updated,
    this.marked = false,
    this.note = "",
    this.imageUrl = "",
    this.url = "",
  });

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);

  Product copyWith({
    int? id,
    String? name,
    String? code,
    int? quantity,
    int? targetQuantity,
    DateTime? created,
    DateTime? updated,
    bool? marked,
    String? note,
    String? imageUrl,
    String? url,
  }) {
    return Product(
      id: id ?? this.id,
      name: name ?? this.name,
      code: code ?? this.code,
      quantity: quantity ?? this.quantity,
      targetQuantity: targetQuantity ?? this.targetQuantity,
      created: created ?? this.created,
      updated: updated ?? this.updated,
      marked: marked ?? this.marked,
      note: note ?? this.note,
      imageUrl: imageUrl ?? this.imageUrl,
      url: url ?? this.url,
    );
  }

  @override
  String toString() {
    return 'Product(id: $id, name: $name, code: $code, quantity: $quantity, targetQuantity: $targetQuantity, created: $created, updated: $updated, marked: $marked, note: $note, imageUrl: $imageUrl, url: $url)';
  }

  @override
  List<Object> get props {
    return [
      id,
      name,
      code,
      quantity,
      targetQuantity,
      created,
      updated,
      marked,
      note,
      imageUrl,
      url,
    ];
  }
}
