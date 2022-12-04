import 'package:equatable/equatable.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'session_model.g.dart';

@JsonSerializable()
@HiveType(typeId: 1)
class Session extends Equatable {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final DateTime startDate;
  @HiveField(3)
  final DateTime? endDate;
  @HiveField(4)
  final String author;
  @HiveField(5)
  final bool downloadUrls;
  @HiveField(6)
  final String note;

  const Session({
    required this.id,
    this.name = "",
    required this.startDate,
    this.endDate,
    this.author = "",
    this.downloadUrls = false,
    this.note = "",
  });

  @override
  String toString() {
    return 'Session(id: $id, name: $name, startDate: $startDate, endDate: $endDate, author: $author, downloadUrls: $downloadUrls, note: $note)';
  }

  @override
  List<Object?> get props {
    return [
      id,
      name,
      startDate,
      endDate,
      author,
      downloadUrls,
      note,
    ];
  }

  factory Session.fromJson(Map<String, dynamic> json) =>
      _$SessionFromJson(json);

  Map<String, dynamic> toJson() => _$SessionToJson(this);

  Session copyWith(
      {String? id,
      String? name,
      DateTime? startDate,
      DateTime? Function()? endDate,
      String? author,
      bool? downloadUrls,
      String? note}) {
    return Session(
      id: id ?? this.id,
      name: name ?? this.name,
      startDate: startDate ?? this.startDate,
      endDate: endDate != null ? endDate() : this.endDate,
      author: author ?? this.author,
      downloadUrls: downloadUrls ?? this.downloadUrls,
      note: note ?? this.note,
    );
  }
}
