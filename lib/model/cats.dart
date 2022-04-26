// To parse this JSON data, do
//
//     final cat = catFromJson(jsonString);

import 'dart:convert';

List<Cat> catFromJson(String str) => List<Cat>.from(json.decode(str).map((x) => Cat.fromJson(x)));

String catToJson(List<Cat> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Cat {
  Cat({
    required this.id,
    required this.v,
    required this.text,
    required this.updatedAt,
    required this.deleted,
    required this.source,
    required this.sentCount,
  });

  final String id;
  final int v;
  final String text;
  final DateTime updatedAt;
  final bool deleted;
  final String source;
  final int sentCount;

  factory Cat.fromJson(Map<String, dynamic> json) => Cat(
    id: json['_id'] == null ? null : json['_id'],
    v: json['__v'] == null ? null : json['__v'],
    text: json['text'] == null ? null : json['text'],
    updatedAt: json['updatedAt'] == null ? null : DateTime.parse(json['updatedAt']),
    deleted: json['deleted'] == null ? null : json['deleted'],
    source: json['source'] == null ? null : json['source'],
    sentCount: json['sentCount'] == null ? null : json['sentCount'],
  );

  Map<String, dynamic> toJson() => {
    '_id': id == null ? null : id,
    '__v': v == null ? null : v,
    'text': text == null ? null : text,
    'updatedAt': updatedAt == null ? null : updatedAt.toIso8601String(),
    'deleted': deleted == null ? null : deleted,
    'source': source == null ? null : source,
    'sentCount': sentCount == null ? null : sentCount,
  };
}
