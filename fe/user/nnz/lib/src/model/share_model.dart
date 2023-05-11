class ShareModel {
  String? showId;
  String? writer;
  String? nanumDate;
  String? title;
  String? openTime;
  String? isCertification;
  String? condition;
  int? quantity;
  String? content;
  List<String>? tags;

  ShareModel({
    this.showId,
    this.writer,
    this.nanumDate,
    this.title,
    this.openTime,
    this.isCertification,
    this.condition,
    this.quantity,
    this.content,
    this.tags,
  });

  factory ShareModel.fromJson(Map<String, dynamic> json) {
    return ShareModel(
      showId: json['showId'],
      writer: json['writer'],
      nanumDate: json['nanumDate'],
      title: json['json'],
      openTime: json['openTime'],
      isCertification: json['isCertification'],
      condition: json['condition'],
      quantity: json['quantity'],
      content: json['content'],
      tags: List<String>.from(json['tags'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'showId': showId,
      'writer': writer,
      'nanumDate': nanumDate,
      'title': title,
      'openTime': openTime,
      'isCertification': isCertification,
      'condition': condition,
      'quantity': quantity,
      'content': content,
      'tags': tags,
    };
  }

  @override
  String toString() {
    return "ShareModel : (showId : $showId, writer : $writer, nanumDate : $nanumDate, title : $title, openTime : $openTime, isCertification : $isCertification, condition : $condition, quantity : $quantity, content :$content, tag : $tags)";
  }
}
