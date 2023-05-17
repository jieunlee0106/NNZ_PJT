class MyShareInfoDetailModel {
  String? title;
  String? location;
  String? date;
  List<Participants>? participants;

  MyShareInfoDetailModel(
      {this.title, this.location, this.date, this.participants});

  MyShareInfoDetailModel.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    location = json['location'];
    date = json['date'];
    if (json['participants'] != null) {
      participants = <Participants>[];
      json['participants'].forEach((v) {
        participants!.add(Participants.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['location'] = location;
    data['date'] = date;
    if (participants != null) {
      data['participants'] = participants!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Participants {
  int? id;
  String? profileImage;
  String? nickname;
  bool? isFollower;
  bool? isReceived;
  bool? isCertificated;

  Participants(
      {this.id,
      this.profileImage,
      this.nickname,
      this.isFollower,
      this.isReceived,
      this.isCertificated});

  Participants.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    profileImage = json['profileImage'];
    nickname = json['nickname'];
    isFollower = json['isFollower'];
    isReceived = json['isReceived'];
    isCertificated = json['isCertificated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['profileImage'] = profileImage;
    data['nickname'] = nickname;
    data['isFollower'] = isFollower;
    data['isReceived'] = isReceived;
    data['isCertificated'] = isCertificated;
    return data;
  }
}
