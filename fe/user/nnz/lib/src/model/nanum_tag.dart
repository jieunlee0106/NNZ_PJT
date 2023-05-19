// To parse this JSON data, do
//
//     final nanumTag = nanumTagFromJson(jsonString);

import 'dart:convert';

NanumTag nanumTagFromJson(String str) => NanumTag.fromJson(json.decode(str));

String nanumTagToJson(NanumTag data) => json.encode(data.toJson());

class NanumTag {
  bool isFirst;
  bool isLast;
  bool isEmpty;
  int totalElements;
  int totalPages;
  List<Content2> content;

  NanumTag({
    required this.isFirst,
    required this.isLast,
    required this.isEmpty,
    required this.totalElements,
    required this.totalPages,
    required this.content,
  });

  factory NanumTag.fromJson(Map<String, dynamic> json) => NanumTag(
        isFirst: json["isFirst"],
        isLast: json["isLast"],
        isEmpty: json["isEmpty"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        content: List<Content2>.from(
            json["content"].map((x) => Content2.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isFirst": isFirst,
        "isLast": isLast,
        "isEmpty": isEmpty,
        "totalElements": totalElements,
        "totalPages": totalPages,
        "content": List<dynamic>.from(content.map((x) => x.toJson())),
      };
}

class Content2 {
  int? id;
  String? title;
  String? poster;

  Content2({
    this.id,
    this.title,
    this.poster,
  });

  factory Content2.fromJson(Map<String, dynamic> json) => Content2(
        id: json["id"],
        title: json["title"],
        poster: json["poster"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "poster": poster,
      };
}
