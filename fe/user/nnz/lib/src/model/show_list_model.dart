import 'dart:convert';

ShowListModel showListModelFromJson(String str) =>
    ShowListModel.fromJson(json.decode(str));

String showListModelToJson(ShowListModel data) => json.encode(data.toJson());

class ShowListModel {
  bool? isFirst;
  bool? isLast;
  bool? empty;
  String? totalElement;
  String? totalPage;
  List<Content>? content;

  ShowListModel({
    this.isFirst,
    this.isLast,
    this.empty,
    this.totalElement,
    this.totalPage,
    this.content,
  });

  factory ShowListModel.fromJson(Map<String, dynamic> json) => ShowListModel(
        isFirst: json["isFirst"],
        isLast: json["isLast"],
        empty: json["empty"],
        totalElement: json["totalElement"],
        totalPage: json["totalPage"],
        content:
            List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isFirst": isFirst,
        "isLast": isLast,
        "empty": empty,
        "totalElement": totalElement,
        "totalPage": totalPage,
        "content": List<dynamic>.from(content!.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "ShowListModel : (isFirst : $isFirst, isLast : $isLast, empty : $empty, totalElement : $totalElement, totalPage : $totalPage, content : $content)";
  }
}

class Content {
  String id;
  String title;
  String startDate;
  String endDate;
  String location;
  String poster;
  List<Tag> tags;

  Content({
    required this.id,
    required this.title,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.poster,
    required this.tags,
  });

  factory Content.fromJson(Map<String, dynamic> json) => Content(
        id: json["id"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        location: json["location"],
        poster: json["poster"],
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "startDate": startDate,
        "endDate": endDate,
        "location": location,
        "poster": poster,
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
      };

  @override
  String toString() {
    return "Content : (id :$id, title, $title, startDate, $startDate, endDate : $endDate, location : $location, poster : $poster, tags : $tags)";
  }
}

class Tag {
  String id;
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
    return "Tags(id : $id, tag : $tag)";
  }
}
