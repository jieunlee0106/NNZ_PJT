// To parse this JSON data, do
//
//     final popularTagModel = popularTagModelFromJson(jsonString);

import 'dart:convert';

List<PopularTagModel> popularTagModelFromJson(String str) => List<PopularTagModel>.from(json.decode(str).map((x) => PopularTagModel.fromJson(x)));

String popularTagModelToJson(List<PopularTagModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PopularTagModel {
    int id;
    String tag;

    PopularTagModel({
        required this.id,
        required this.tag,
    });

    factory PopularTagModel.fromJson(Map<String, dynamic> json) => PopularTagModel(
        id: json["id"],
        tag: json["tag"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
    };

    @override
  String toString() {
    return "PopularTagModel : (id : $id, tag : $tag)";
  }
}
