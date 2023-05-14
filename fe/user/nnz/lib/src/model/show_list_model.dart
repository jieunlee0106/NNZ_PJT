// To parse this JSON data, do
//
//     final showListModel = showListModelFromJson(jsonString);

import 'dart:convert';

ShowListModel showListModelFromJson(String str) =>
    ShowListModel.fromJson(json.decode(str));

String showListModelToJson(ShowListModel data) => json.encode(data.toJson());

class ShowListModel {
  bool isFirst;
  bool isLast;
  bool isEmpty;
  int totalElements;
  int totalPages;
  List<Content> content;

  ShowListModel({
    required this.isFirst,
    required this.isLast,
    required this.isEmpty,
    required this.totalElements,
    required this.totalPages,
    required this.content,
  });

  factory ShowListModel.fromJson(Map<String, dynamic> json) => ShowListModel(
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
  String location;
  String startDate;
  String endDate;
  String ageLimit;
  Region region;
  List<dynamic> showTags;
  String poster;
  dynamic categoryCode;
  DateTime updatedAt;

  Content({
    required this.id,
    required this.title,
    required this.location,
    required this.startDate,
    required this.endDate,
    required this.ageLimit,
    required this.region,
    required this.showTags,
    required this.poster,
    this.categoryCode,
    required this.updatedAt,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        location: json["location"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        ageLimit: json["ageLimit"],
        region: regionValues.map[json["region"]]!,
        showTags: List<dynamic>.from(json["showTags"].map((x) => x)),
        poster: json["poster"],
        categoryCode: json["categoryCode"],
        updatedAt: DateTime.parse(json["updatedAt"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "location": location,
        "startDate": startDate,
        "endDate": endDate,
        "ageLimit": ageLimit,
        "region": regionValues.reverse[region],
        "showTags": List<dynamic>.from(showTags.map((x) => x)),
        "poster": poster,
        "categoryCode": categoryCode,
        "updatedAt": updatedAt.toIso8601String(),
      };
}

enum Region { EMPTY }

final regionValues = EnumValues({"서울": Region.EMPTY});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
