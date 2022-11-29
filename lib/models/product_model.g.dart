// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class ProductAdapter extends TypeAdapter<Product> {
  @override
  final int typeId = 2;

  @override
  Product read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Product(
      id: fields[0] as int,
      name: fields[1] as String,
      code: fields[2] as String,
      quantity: fields[3] as int,
      targetQuantity: fields[4] as int,
      created: fields[5] as DateTime,
      updated: fields[6] as DateTime,
      marked: fields[7] as bool,
      note: fields[8] as String,
      imageUrl: fields[9] as String?,
      url: fields[10] as String?,
    );
  }

  @override
  void write(BinaryWriter writer, Product obj) {
    writer
      ..writeByte(11)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.name)
      ..writeByte(2)
      ..write(obj.code)
      ..writeByte(3)
      ..write(obj.quantity)
      ..writeByte(4)
      ..write(obj.targetQuantity)
      ..writeByte(5)
      ..write(obj.created)
      ..writeByte(6)
      ..write(obj.updated)
      ..writeByte(7)
      ..write(obj.marked)
      ..writeByte(8)
      ..write(obj.note)
      ..writeByte(9)
      ..write(obj.imageUrl)
      ..writeByte(10)
      ..write(obj.url);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ProductAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Product _$ProductFromJson(Map<String, dynamic> json) => Product(
      id: json['id'] as int? ?? 0,
      name: json['name'] as String,
      code: json['code'] as String,
      quantity: json['quantity'] as int? ?? 0,
      targetQuantity: json['targetQuantity'] as int,
      created: DateTime.parse(json['created'] as String),
      updated: DateTime.parse(json['updated'] as String),
      marked: json['marked'] as bool? ?? false,
      note: json['note'] as String? ?? "",
      imageUrl: json['imageUrl'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ProductToJson(Product instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'code': instance.code,
      'quantity': instance.quantity,
      'targetQuantity': instance.targetQuantity,
      'created': instance.created.toIso8601String(),
      'updated': instance.updated.toIso8601String(),
      'marked': instance.marked,
      'note': instance.note,
      'imageUrl': instance.imageUrl,
      'url': instance.url,
    };
