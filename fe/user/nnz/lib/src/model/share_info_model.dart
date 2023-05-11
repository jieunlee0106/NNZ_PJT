import 'dart:convert';

ShareInfoModel shareInfoModelFromJson(String str) =>
    ShareInfoModel.fromJson(json.decode(str));

String shareInfoModelToJson(ShareInfoModel data) => json.encode(data.toJson());

class ShareInfoModel {
  String nanumTime;
  String location;
  String lat;
  String lng;
  String outfit;

  ShareInfoModel({
    required this.nanumTime,
    required this.location,
    required this.lat,
    required this.lng,
    required this.outfit,
  });

  factory ShareInfoModel.fromJson(Map<String, dynamic> json) => ShareInfoModel(
        nanumTime: json["nanumTime"],
        location: json["location"],
        lat: json["lat"],
        lng: json["lng"],
        outfit: json["outfit"],
      );

  Map<String, dynamic> toJson() => {
        "nanumTime": nanumTime,
        "location": location,
        "lat": lat,
        "lng": lng,
        "outfit": outfit,
      };
}
