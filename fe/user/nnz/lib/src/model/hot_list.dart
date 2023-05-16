// To parse this JSON data, do
//
//     final hotList = hotListFromJson(jsonString);

import 'dart:convert';

List<HotList> hotListFromJson(String str) =>
    List<HotList>.from(json.decode(str).map((x) => HotList.fromJson(x)));

String hotListToJson(List<HotList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class HotList {
  int id;
  String title;
  String poster;

  HotList({
    required this.id,
    required this.title,
    required this.poster,
  });

  factory HotList.fromJson(Map<String, dynamic> json) => HotList(
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
