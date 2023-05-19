// To parse this JSON data, do
//
//     final showTag = showTagFromJson(jsonString);

import 'dart:convert';

ShowTag showTagFromJson(String str) => ShowTag.fromJson(json.decode(str));

String showTagToJson(ShowTag data) => json.encode(data.toJson());

class ShowTag {
  bool isFirst;
  bool isLast;
  bool isEmpty;
  int totalElements;
  int totalPages;
  List<Content> content;

  ShowTag({
    required this.isFirst,
    required this.isLast,
    required this.isEmpty,
    required this.totalElements,
    required this.totalPages,
    required this.content,
  });

  factory ShowTag.fromJson(Map<String, dynamic> json) => ShowTag(
        isFirst: json["isFirst"],
        isLast: json["isLast"],
        isEmpty: json["isEmpty"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
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

class Content {
  int id;
  String title;
  String poster;

  Content({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
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
