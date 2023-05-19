class ShareInfoModel {
  String? nanumTime;
  String? location;
  String? lat;
  String? lng;
  String? outfit;
  int? receiveId;

  ShareInfoModel(
      {this.nanumTime,
      this.location,
      this.lat,
      this.lng,
      this.outfit,
      this.receiveId});

  ShareInfoModel.fromJson(Map<String, dynamic> json) {
    nanumTime = json['nanumTime'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    outfit = json['outfit'];
    receiveId = json['receiveId'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nanumTime'] = nanumTime;
    data['location'] = location;
    data['lat'] = lat;
    data['lng'] = lng;
    data['outfit'] = outfit;
    data['receiveId'] = receiveId;
    return data;
  }
}
