// To parse this JSON data, do
//
//     final sportModel = sportModelFromJson(jsonString);

import 'dart:convert';

EsportModel sportModelFromJson(String str) =>
    EsportModel.fromJson(json.decode(str));

String sportModelToJson(EsportModel data) => json.encode(data.toJson());

class EsportModel {
  bool isFirst;
  bool isLast;
  bool isEmpty;
  int totalElements;
  int totalPages;
  List<Content> content;

  EsportModel({
    required this.isFirst,
    required this.isLast,
    required this.isEmpty,
    required this.totalElements,
    required this.totalPages,
    required this.content,
  });

  factory EsportModel.fromJson(Map<String, dynamic> json) => EsportModel(
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
  int? id;
  String? leftTeam;
  String? rightTeam;
  String? location;
  String? date;
  int? ageLimit;
  List<dynamic>? showTags;
  String? leftTeamImage;
  String? rightTeamImage;

  Content({
    required this.id,
    required this.leftTeam,
    required this.rightTeam,
    required this.location,
    required this.date,
    this.ageLimit,
    required this.showTags,
    required this.leftTeamImage,
    required this.rightTeamImage,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        leftTeam: json["leftTeam"],
        rightTeam: json["rightTeam"],
        location: json["location"],
        date: json["date"],
        ageLimit: json["ageLimit"],
        showTags: List<dynamic>.from(json["showTags"].map((x) => x)),
        leftTeamImage: json["leftTeamImage"],
        rightTeamImage: json["rightTeamImage"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "leftTeam": leftTeam,
        "rightTeam": rightTeam,
        "location": location,
        "date": date,
        "ageLimit": ageLimit,
        // "showTags": List<dynamic>.from(showTags.map((x) => x)),
        "leftTeamImage": leftTeamImage,
        "rightTeamImage": rightTeamImage,
      };
}

// enum Date {
//   THE_2023510_T18_30,
//   THE_2023511_T18_30,
//   THE_2023512_T18_30,
//   THE_2023513_T17_00
// }

// final dateValues = EnumValues({
//   "2023.5.10T18:30": Date.THE_2023510_T18_30,
//   "2023.5.11T18:30": Date.THE_2023511_T18_30,
//   "2023.5.12T18:30": Date.THE_2023512_T18_30,
//   "2023.5.13T17:00": Date.THE_2023513_T17_00
// });

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
