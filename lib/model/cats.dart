// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';
import 'package:hive/hive.dart';

List<Cat> catFromJson(dynamic str) =>
    List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

String catToJson(List<Cat> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

@HiveType(typeId: 0)
class Cat extends HiveObject {
  Cat({
    @HiveField(0) required this.id,
    @HiveField(1) required this.v,
    @HiveField(2) required this.text,
    @HiveField(3) required this.updatedAt,
    @HiveField(4) required this.deleted,
    @HiveField(5) required this.source,
    @HiveField(6) required this.sentCount,
  });

  final String id;
  final int v;
  final String text;
  final DateTime updatedAt;
  final bool deleted;
  final String source;
  final int sentCount;

  Cat copyWith({
    String? id,
    int? v,
    String? text,
    DateTime? updatedAt,
    bool? deleted,
    String? source,
    int? sentCount,
  }) =>
      Cat(
        id: id ?? this.id,
        v: v ?? this.v,
        text: text ?? this.text,
        updatedAt: updatedAt ?? this.updatedAt,
        deleted: deleted ?? this.deleted,
        source: source ?? this.source,
        sentCount: sentCount ?? this.sentCount,
      );

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
        id: json["_id"],
        v: json["__v"],
        text: json["text"],
        updatedAt: json["updatedAt"],
        deleted: json["deleted"],
        source: json["source"],
        sentCount: json["sentCount"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "__v": v,
        "text": text,
        "updatedAt": updatedAt,
        "deleted": deleted,
        "source": source,
        "sentCount": sentCount,
      };
}
