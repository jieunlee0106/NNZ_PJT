class OtherShareInfoModel {
  String? nanumTime;
  String? location;
  String? lat;
  String? lng;
  String? outfit;

  OtherShareInfoModel(
      {this.nanumTime, this.location, this.lat, this.lng, this.outfit});

  OtherShareInfoModel.fromJson(Map<String, dynamic> json) {
    nanumTime = json['nanumTime'];
    location = json['location'];
    lat = json['lat'];
    lng = json['lng'];
    outfit = json['outfit'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nanumTime'] = this.nanumTime;
    data['location'] = this.location;
    data['lat'] = this.lat;
    data['lng'] = this.lng;
    data['outfit'] = this.outfit;
    return data;
  }
}