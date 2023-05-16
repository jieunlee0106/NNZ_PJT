// To parse this JSON data, do
//
//     final locationList = locationListFromJson(jsonString);

import 'dart:convert';

LocationList locationListFromJson(String str) =>
    LocationList.fromJson(json.decode(str));

String locationListToJson(LocationList data) => json.encode(data.toJson());

class LocationList {
  bool isFirst;
  bool isLast;
  bool isEmpty;
  int totalElements;
  int totalPages;
  List<Content> content;

  LocationList({
    required this.isFirst,
    required this.isLast,
    required this.isEmpty,
    required this.totalElements,
    required this.totalPages,
    required this.content,
  });

  factory LocationList.fromJson(Map<String, dynamic> json) => LocationList(
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
  int providerId;
  String title;
  DateTime nanumDate;
  DateTime openTime;
  bool isCertification;
  String condition;
  int quantity;
  int stock;
  String content;
  int status;
  String thumbnail;
  DateTime nanumTime;
  String location;
  String lat;
  String lng;
  String outfit;
  int showId;
  dynamic views;

  Content({
    required this.id,
    required this.providerId,
    required this.title,
    required this.nanumDate,
    required this.openTime,
    required this.isCertification,
    required this.condition,
    required this.quantity,
    required this.stock,
    required this.content,
    required this.status,
    required this.thumbnail,
    required this.nanumTime,
    required this.location,
    required this.lat,
    required this.lng,
    required this.outfit,
    required this.showId,
    this.views,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        providerId: json["providerId"],
        title: json["title"],
        nanumDate: DateTime.parse(json["nanumDate"]),
        openTime: DateTime.parse(json["openTime"]),
        isCertification: json["isCertification"],
        condition: json["condition"],
        quantity: json["quantity"],
        stock: json["stock"],
        content: json["content"],
        status: json["status"],
        thumbnail: json["thumbnail"],
        nanumTime: DateTime.parse(json["nanumTime"]),
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
        outfit: json["outfit"],
        showId: json["showId"],
        views: json["views"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "providerId": providerId,
        "title": title,
        "nanumDate":
            "${nanumDate.year.toString().padLeft(4, '0')}-${nanumDate.month.toString().padLeft(2, '0')}-${nanumDate.day.toString().padLeft(2, '0')}",
        "openTime": openTime.toIso8601String(),
        "isCertification": isCertification,
        "condition": condition,
        "quantity": quantity,
        "stock": stock,
        "content": content,
        "status": status,
        "thumbnail": thumbnail,
        "nanumTime": nanumTime.toIso8601String(),
        "location": location,
        "lat": lat,
        "lng": lng,
        "outfit": outfit,
        "showId": showId,
        "views": views,
      };
}
