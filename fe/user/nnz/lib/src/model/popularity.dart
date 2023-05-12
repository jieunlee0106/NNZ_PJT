class PopularityList {
  int? id;
  String? title;
  String? thumbnail;
  List<Tags>? tags;
  int? status;
  Show? show;

  PopularityList({
    this.id,
    this.title,
    this.thumbnail,
    this.tags,
    this.status,
    this.show,
  });

  PopularityList.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    status = json['status'];
    show = json['show'] != null ? Show.fromJson(json['show']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (show != null) {
      data['show'] = show!.toJson();
    }
    return data;
  }
}

class Tags {
  int? id;
  String? tag;

  Tags({this.id, this.tag});

  Tags.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    tag = json['tag'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['tag'] = tag;
    return data;
  }
}

class Show {
  int? id;
  String? title;
  String? location;

  Show({this.id, this.title, this.location});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    location = json['location'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['id'] = id;
    data['title'] = title;
    data['location'] = location;
    return data;
  }
}
