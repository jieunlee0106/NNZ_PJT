// To parse this JSON data, do
//
//     final searchNanumModel = searchNanumModelFromJson(jsonString);

import 'dart:convert';

SearchNanumModel searchNanumModelFromJson(String str) =>
    SearchNanumModel.fromJson(json.decode(str));

String searchNanumModelToJson(SearchNanumModel data) =>
    json.encode(data.toJson());

class SearchNanumModel {
  Nanums nanums;

  SearchNanumModel({
    required this.nanums,
  });

  factory SearchNanumModel.fromJson(Map<String, dynamic> json) =>
      SearchNanumModel(
        nanums: Nanums.fromJson(json["nanums"]),
      );

  Map<String, dynamic> toJson() => {
        "nanums": nanums.toJson(),
      };
}

class Nanums {
  bool? isFirst;
  bool? isLast;
  bool? isEmpty;
  int? totalElements;
  int? totalPages;
  List<Content>? content;

  Nanums({
    this.isFirst,
    this.isLast,
    this.isEmpty,
    this.totalElements,
    this.totalPages,
    this.content,
  });

  factory Nanums.fromJson(Map<String, dynamic> json) => Nanums(
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
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };
  @override
  String toString() {
    return "SearchNanumListModel : (isFirst : $isFirst, isLast : $isLast, isEmpty : $isEmpty, totalElements : $totalElements, totalPages : $totalPages, content : $content)";
  }
}

class Content {
  int? id;
  String? thumbnail;
  String? title;
  DateTime? nanumDate;
  List<Tag>? tags;
  Show? show;

  Content({
    this.id,
    this.thumbnail,
    this.title,
    this.nanumDate,
    this.tags,
    this.show,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        thumbnail: json["thumbnail"],
        title: json["title"],
        nanumDate: DateTime.parse(json["nanumDate"]),
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        show: Show.fromJson(json["show"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "thumbnail": thumbnail,
        "title": title,
        "nanumDate":
            "${nanumDate!.year.toString().padLeft(4, '0')}-${nanumDate!.month.toString().padLeft(2, '0')}-${nanumDate!.day.toString().padLeft(2, '0')}",
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
        "show": show!.toJson(),
      };

  @override
  String toString() {
    return "Content : (id : $id, thumbnail : $thumbnail, title : $title, nanumData : $nanumDate, tags : $tags, show : $show)";
  }
}

class Show {
  dynamic title;
  dynamic location;

  Show({
    this.title,
    this.location,
  });

  factory Show.fromJson(Map<String, dynamic> json) => Show(
        title: json["title"],
        location: json["location"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "location": location,
      };

  @override
  String toString() {
    return "Show : (title : $title, location : $location)";
  }
}

class Tag {
  int id;
  String tag;

  Tag({
    required this.id,
    required this.tag,
  });

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["id"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
      };

  @override
  String toString() {
    return "Tag : (id : $id, tag : $tag)";
  }
}
