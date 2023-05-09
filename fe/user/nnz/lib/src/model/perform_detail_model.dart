class PerformDetailModel {
  String? id;
  String? title;
  String? location;
  String? date;
  String? ageLimit;
  List<TagModel>? tags;
  String? poster;

  PerformDetailModel(
      {this.id,
      this.title,
      this.location,
      this.date,
      this.ageLimit,
      this.tags,
      this.poster});

  PerformDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
    date = json['date'];
    ageLimit = json['ageLimit'];
    if (json['tags'] != null) {
      tags = <TagModel>[];
      json['tags'].forEach((v) {
        tags!.add(TagModel.fromJson(v));
      });
    }
    poster = json['poster'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    data['date'] = date;
    data['ageLimit'] = ageLimit;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['poster'] = poster;
    return data;
  }
}

class TagModel {
  String? id;
  String? tag;

  TagModel({this.id, this.tag});

  TagModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tag'] = tag;
    return data;
  }
}
