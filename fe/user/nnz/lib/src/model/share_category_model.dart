// To parse this JSON data, do
//
//     final shareCategoryModel = shareCategoryModelFromJson(jsonString);

import 'dart:convert';

List<ShareCategoryModel> shareCategoryModelFromJson(String str) =>
    List<ShareCategoryModel>.from(
        json.decode(str).map((x) => ShareCategoryModel.fromJson(x)));

String shareCategoryModelToJson(List<ShareCategoryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class ShareCategoryModel {
  String? code;
  String? name;

  ShareCategoryModel({
    this.code,
    this.name,
  });

  factory ShareCategoryModel.fromJson(Map<String, dynamic> json) =>
      ShareCategoryModel(
        code: json["code"],
        name: json["name"],
      );

  Map<String, dynamic> toJson() => {
        "code": code,
        "name": name,
      };
}
