class ShareRequestListModel {
  String? id;
  String? email;
  String? image;

  ShareRequestListModel({this.id, this.email, this.image});

  ShareRequestListModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    email = json['email'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['email'] = email;
    data['image'] = image;
    return data;
  }
}
