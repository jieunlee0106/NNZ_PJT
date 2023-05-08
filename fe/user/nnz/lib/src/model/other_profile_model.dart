import 'dart:convert';

OtherProfileModel otherProfileModelFromJson(String str) =>
    OtherProfileModel.fromJson(json.decode(str));

String otherProfileModelToJson(OtherProfileModel data) =>
    json.encode(data.toJson());

class OtherProfileModel {
  String? id;
  String? nickname;
  String? profileImage;
  String? isFollow;
  String? isTwitterFollow;
  String? followerCount;
  String? followingCount;
  Statistics? statistics;

  OtherProfileModel({
    this.id,
    this.nickname,
    this.profileImage,
    this.isFollow,
    this.isTwitterFollow,
    this.followerCount,
    this.followingCount,
    this.statistics,
  });

  factory OtherProfileModel.fromJson(Map<String, dynamic> json) =>
      OtherProfileModel(
        id: json["id"],
        nickname: json["nickname"],
        profileImage: json["profileImage"],
        isFollow: json["isFollow"],
        isTwitterFollow: json["isTwitterFollow"],
        followerCount: json["followerCount"],
        followingCount: json["followingCount"],
        statistics: Statistics.fromJson(json["statistics"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nickname": nickname,
        "profileImage": profileImage,
        "isFollow": isFollow,
        "isTwitterFollow": isTwitterFollow,
        "followerCount": followerCount,
        "followingCount": followingCount,
        "statistics": statistics!.toJson(),
      };

  @override
  String toString() {
    return "OtherProfileModel : (id : $id, nickname : $nickname, profileImage : $profileImage, isFollow : $isFollow, isTwitterFollow : $isTwitterFollow, followerCount : $followerCount, followingCount : $followingCount, statistics : $statistics)";
  }
}

class Statistics {
  String total;
  String nanumCount;
  String receiveCount;

  Statistics({
    required this.total,
    required this.nanumCount,
    required this.receiveCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        total: json["total"],
        nanumCount: json["nanumCount"],
        receiveCount: json["receiveCount"],
      );

  Map<String, dynamic> toJson() => {
        "total": total,
        "nanumCount": nanumCount,
        "receiveCount": receiveCount,
      };

  @override
  String toString() {
    return "Statistics : (total : $total, nanumCount : $nanumCount, receiveCount : $receiveCount)";
  }
}
