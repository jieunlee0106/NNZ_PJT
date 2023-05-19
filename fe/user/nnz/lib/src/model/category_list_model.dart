import 'dart:convert';

CategoryListModel registerModelFromJson(String str) =>
    CategoryListModel.fromJson(json.decode(str));

String registerModelToJson(CategoryListModel data) => json.encode(data.toJson());

class CategoryListModel {
  String? id;
  String? title;
  String? startDate;
  String? endDate;
  String? location;
  String? poster;


  CategoryListModel({
    this.id,
    this.title,
    this.startDate,
    this.endDate,
    this.location,
    this.poster,

  });

  
  factory CategoryListModel.fromJson(Map<String, dynamic> json) => CategoryListModel(
        id: json["id"],
        title: json["title"],
        startDate: json["startDate"],
        endDate: json["endDate"],
        location: json["location"],
        poster: json["poster"]
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "image": poster,
        "date": "$startDate ~ $endDate",
        "location": location,

      };

  @override
  String toString() {
    return "RegisterModel (title : $title, image: $poster, location : $location, date : $startDate ~ $endDate,)";
  }
}
