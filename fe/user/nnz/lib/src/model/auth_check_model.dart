class AuthCheckModel {
  int? id;
  bool? certification;

  AuthCheckModel({this.id, this.certification});

  AuthCheckModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    certification = json['certification'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['certification'] = certification;
    return data;
  }
}
