// To parse this JSON data, do
//
//     final popular = popularFromJson(jsonString);

import 'dart:convert';

List<Popular> popularFromJson(String str) =>
    List<Popular>.from(json.decode(str).map((x) => Popular.fromJson(x)));

String popularToJson(List<Popular> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Popular {
  int id;
  String title;
  String poster;

  Popular({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory Popular.fromJson(Map<String, dynamic> json) => Popular(
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
