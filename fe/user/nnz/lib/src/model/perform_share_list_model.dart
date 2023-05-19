class ShareListModel {
  bool? isFirst;
  bool? isLast;
  bool? empty;
  int? totalElement;
  int? totalPage;
  List<Content>? content;

  ShareListModel(
      {this.isFirst,
      this.isLast,
      this.empty,
      this.totalElement,
      this.totalPage,
      this.content});

  ShareListModel.fromJson(Map<String, dynamic> json) {
    isFirst = json['isFirst'];
    isLast = json['isLast'];
    empty = json['empty'];
    totalElement = json['totalElement'];
    totalPage = json['totalPage'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['isFirst'] = isFirst;
    data['isLast'] = isLast;
    data['empty'] = empty;
    data['totalElement'] = totalElement;
    data['totalPage'] = totalPage;
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int? id;
  String? title;
  String? thumbnail;
  String? date;
  List<Tags>? tags;
  int? status;

  Content(
      {this.id, this.title, this.thumbnail, this.date, this.tags, this.status});

  Content.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    thumbnail = json['thumbnail'];
    date = json['date'];
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['thumbnail'] = thumbnail;
    data['date'] = date;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
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
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['tag'] = tag;
    return data;
  }
}
