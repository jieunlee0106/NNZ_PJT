
import 'dart:convert';

SearchShowListModel searchShowListModelFromJson(String str) => SearchShowListModel.fromJson(json.decode(str));

String searchShowListModelToJson(SearchShowListModel data) => json.encode(data.toJson());

class SearchShowListModel {
    Shows shows;

    SearchShowListModel({
        required this.shows,
    });

    factory SearchShowListModel.fromJson(Map<String, dynamic> json) => SearchShowListModel(
        shows: Shows.fromJson(json["shows"]),
    );

    Map<String, dynamic> toJson() => {
        "shows": shows.toJson(),
    };
}

class Shows {
    bool? isFirst;
    bool? isLast;
    bool? isEmpty;
    int? totalElements;
    int? totalPages;
    List<Content>? content;

    Shows({
         this.isFirst,
         this.isLast,
         this.isEmpty,
         this.totalElements,
         this.totalPages,
         this.content,
    });

    factory Shows.fromJson(Map<String, dynamic> json) => Shows(
        isFirst: json["isFirst"],
        isLast: json["isLast"],
        isEmpty: json["isEmpty"],
        totalElements: json["totalElements"],
        totalPages: json["totalPages"],
        content: List<Content>.from(json["content"].map((x) => Content.fromJson(x))),
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
    return "SearchShowListModel : (isFirst : $isFirst, isLast : $isLast, isEmpty : $isEmpty, totalElements :$totalElements, totalPages : $totalPages, content : $content)";
  }
}

class Content {
    int? id;
    String? title;
    String? startDate;
    dynamic? endDate;
    dynamic? location;
    dynamic? poster;
    List<Tag>? tags;

    Content({
        this.id,
        this.title,
        this.startDate,
        this.endDate,
        this.location,
        this.poster,
        this.tags,
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
        "tags": List<dynamic>.from(tags!.map((x) => x.toJson())),
    };

    @override
  String toString() {
    return "Content : (id : $id, title, $title, startDate : $startDate, endDate : $endDate, location : $location, poster :$poster, tags : $tags)";
  }
}

class Tag {
    int? id;
    String? tag;

    Tag({
        this.id,
        this.tag,
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
    return "Tag : (id :$id, tag :  $tag)";
  }
}
