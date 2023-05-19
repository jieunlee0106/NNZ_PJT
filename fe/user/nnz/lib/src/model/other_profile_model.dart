import 'dart:convert';

OtherUserProfileModel otherUserProfileModelFromJson(String str) =>
    OtherUserProfileModel.fromJson(json.decode(str));

String otherUserProfileModelToJson(OtherUserProfileModel data) =>
    json.encode(data.toJson());

class OtherUserProfileModel {
  int? id;
  String? nickname;
  String? profileImage;
  bool? isFollow;
  dynamic isTwitterFollow;
  int? followerCount;
  int? followingCount;
  Statistics? statistics;

  OtherUserProfileModel({
    this.id,
    this.nickname,
    this.profileImage,
    this.isFollow,
    this.isTwitterFollow,
    this.followerCount,
    this.followingCount,
    this.statistics,
  });

  factory OtherUserProfileModel.fromJson(Map<String, dynamic> json) =>
      OtherUserProfileModel(
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
    return "OtherProfileUserModel : (id : $id, nickname : $nickname, profileImage : $profileImage, isFollow : $isFollow, isTwitterFollow : $isTwitterFollow, followerCount : $followerCount, followingCount : $followingCount, statistics :  $statistics)";
  }
}

class Statistics {
  int totalCount;
  int nanumCount;
  int receiveCount;

  Statistics({
    required this.totalCount,
    required this.nanumCount,
    required this.receiveCount,
  });

  factory Statistics.fromJson(Map<String, dynamic> json) => Statistics(
        totalCount: json["totalCount"],
        nanumCount: json["nanumCount"],
        receiveCount: json["receiveCount"],
      );

  Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "nanumCount": nanumCount,
        "receiveCount": receiveCount,
      };

  @override
  String toString() {
    return "Statistics : (totalCount : $totalCount, nanumCount : $nanumCount, receiveCount : $receiveCount)";
  }
}
