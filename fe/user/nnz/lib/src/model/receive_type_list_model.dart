// To parse this JSON data, do
//
//     final receiveTypeList = receiveTypeListFromJson(jsonString);

import 'dart:convert';

List<ReceiveTypeList> receiveTypeListFromJson(String str) =>
    List<ReceiveTypeList>.from(
        json.decode(str).map((x) => ReceiveTypeList.fromJson(x)));

String receiveTypeListToJson(List<ReceiveTypeList> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ReceiveTypeList {
  String thumbnail;
  String title;
  String date;
  String location;
  int status;
  bool isCertification;

  ReceiveTypeList({
    required this.thumbnail,
    required this.title,
    required this.date,
    required this.location,
    required this.status,
    required this.isCertification,
  });

  factory ReceiveTypeList.fromJson(Map<String, dynamic> json) =>
      ReceiveTypeList(
        thumbnail: json["thumbnail"],
        title: json["title"],
        date: json["date"],
        location: json["location"],
        status: json["status"],
        isCertification: json["isCertification"],
      );

  Map<String, dynamic> toJson() => {
        "thumbnail": thumbnail,
        "title": title,
        "date": date,
        "location": location,
        "status": status,
        "isCertification": isCertification,
      };
}
