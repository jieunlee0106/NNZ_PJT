import 'dart:convert';

List<TagListModel> tagListModelFromJson(String str) => List<TagListModel>.from(
    json.decode(str).map((x) => TagListModel.fromJson(x)));

String tagListModelToJson(List<TagListModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class TagListModel {
  int? id;
  String? tag;

  TagListModel({
    this.id,
    this.tag,
  });

  factory TagListModel.fromJson(Map<String, dynamic> json) => TagListModel(
        id: json["id"],
        tag: json["tag"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "tag": tag,
      };

  @override
  String toString() {
    return "TagListModel : (id : $id, $tag)";
  }
}
