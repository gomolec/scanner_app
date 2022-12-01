// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'history_action_model.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class HistoryActionAdapter extends TypeAdapter<HistoryAction> {
  @override
  final int typeId = 3;

  @override
  HistoryAction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return HistoryAction(
      id: fields[0] as int,
      oldProduct: fields[1] as Product?,
      updatedProduct: fields[2] as Product?,
      isRedo: fields[3] as bool,
    );
  }

  @override
  void write(BinaryWriter writer, HistoryAction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.id)
      ..writeByte(1)
      ..write(obj.oldProduct)
      ..writeByte(2)
      ..write(obj.updatedProduct)
      ..writeByte(3)
      ..write(obj.isRedo);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is HistoryActionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoryAction _$HistoryActionFromJson(Map<String, dynamic> json) =>
    HistoryAction(
      id: json['id'] as int,
      oldProduct: json['oldProduct'] == null
          ? null
          : Product.fromJson(json['oldProduct'] as Map<String, dynamic>),
      updatedProduct: json['updatedProduct'] == null
          ? null
          : Product.fromJson(json['updatedProduct'] as Map<String, dynamic>),
      isRedo: json['isRedo'] as bool,
    );

Map<String, dynamic> _$HistoryActionToJson(HistoryAction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'oldProduct': instance.oldProduct,
      'updatedProduct': instance.updatedProduct,
      'isRedo': instance.isRedo,
    };
