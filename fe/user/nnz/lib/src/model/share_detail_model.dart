class ShareDetailModel {
  int? id;
  String? title;
  String? nanumDate;
  String? leftTime;
  List<String>? thumbnails;
  List<Tags>? tags;
  int? status;
  Show? show;
  bool? isCertification;
  String? condition;
  Writer? writer;
  String? content;
  bool? isBookmark;
  bool? isBooking;

  ShareDetailModel(
      {this.id,
      this.title,
      this.nanumDate,
      this.leftTime,
      this.thumbnails,
      this.tags,
      this.status,
      this.show,
      this.isCertification,
      this.condition,
      this.writer,
      this.content,
      this.isBookmark,
      this.isBooking});

  ShareDetailModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    nanumDate = json['nanumDate'];
    leftTime = json['leftTime'];
    thumbnails = json['thumbnails'].cast<String>();
    if (json['tags'] != null) {
      tags = <Tags>[];
      json['tags'].forEach((v) {
        tags!.add(Tags.fromJson(v));
      });
    }
    status = json['status'];
    show = json['show'] != null ? Show.fromJson(json['show']) : null;
    isCertification = json['isCertification'];
    condition = json['condition'];
    writer = json['writer'] != null ? Writer.fromJson(json['writer']) : null;
    content = json['content'];
    isBookmark = json['isBookmark'];
    isBooking = json['isBooking'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['nanumDate'] = nanumDate;
    data['leftTime'] = leftTime;
    data['thumbnails'] = thumbnails;
    if (tags != null) {
      data['tags'] = tags!.map((v) => v.toJson()).toList();
    }
    data['status'] = status;
    if (show != null) {
      data['show'] = show!.toJson();
    }
    data['isCertification'] = isCertification;
    data['condition'] = condition;
    if (writer != null) {
      data['writer'] = writer!.toJson();
    }
    data['content'] = content;
    data['isBookmark'] = isBookmark;
    data['isBooking'] = isBooking;
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

class Show {
  int? id;
  String? title;

  Show({this.id, this.title});

  Show.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    return data;
  }
}

class Writer {
  int? id;
  String? nickname;
  String? profileImage;
  bool? isFollow;

  Writer({this.id, this.nickname, this.profileImage, this.isFollow});

  Writer.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    nickname = json['nickname'];
    profileImage = json['profileImage'];
    isFollow = json['isFollow'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['nickname'] = nickname;
    data['profileImage'] = profileImage;
    data['isFollow'] = isFollow;
    return data;
  }
}
