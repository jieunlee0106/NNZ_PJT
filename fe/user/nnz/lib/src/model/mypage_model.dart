class MyPageModel {
  int? id;
  String? email;
  String? nickname;
  String? phone;
  String? profileImage;
  String? authProvider;
  int? followerCount;
  int? followingCount;
  Statistics? statistics;

  MyPageModel({
    this.id,
    this.email,
    this.nickname,
    this.phone,
    this.profileImage,
    this.authProvider,
    this.followerCount,
    this.followingCount,
    this.statistics,
  });

  MyPageModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    nickname = json['nickname'];
    phone = json['phone'];
    profileImage = json['profileImage'];
    authProvider = json['authProvider'];
    followerCount = json['followerCount'];
    followingCount = json['followingCount'];
    statistics = json['statistics'] != null
        ? new Statistics.fromJson(json['statistics'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['email'] = this.email;
    data['nickname'] = this.nickname;
    data['phone'] = this.phone;
    data['profileImage'] = this.profileImage;
    data['authProvider'] = this.authProvider;
    data['followerCount'] = this.followerCount;
    data['followingCount'] = this.followingCount;
    print(nickname);
    if (this.statistics != null) {
      data['statistics'] = this.statistics!.toJson();
    }

    return data;
  }
}

class Statistics {
  Nanum? nanum;
  Nanum? receive;

  Statistics({this.nanum, this.receive});

  Statistics.fromJson(Map<String, dynamic> json) {
    nanum = json['nanum'] != null ? new Nanum.fromJson(json['nanum']) : null;
    receive =
        json['receive'] != null ? new Nanum.fromJson(json['receive']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.nanum != null) {
      data['nanum'] = this.nanum!.toJson();
    }
    if (this.receive != null) {
      data['receive'] = this.receive!.toJson();
    }
    return data;
  }
}

class Nanum {
  int? totalCount;
  int? beforeCount;
  int? ongoingCount;
  int? doneCount;

  Nanum({this.totalCount, this.beforeCount, this.ongoingCount, this.doneCount});

  Nanum.fromJson(Map<String, dynamic> json) {
    totalCount = json['totalCount'];
    beforeCount = json['beforeCount'];
    ongoingCount = json['ongoingCount'];
    doneCount = json['doneCount'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['totalCount'] = this.totalCount;
    data['beforeCount'] = this.beforeCount;
    data['ongoingCount'] = this.ongoingCount;
    data['doneCount'] = this.doneCount;
    return data;
  }
}
