class ShareStockModel {
  int? quantity;
  int? stock;

  ShareStockModel({this.quantity, this.stock});

  ShareStockModel.fromJson(Map<String, dynamic> json) {
    quantity = json['quantity'];
    stock = json['stock'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['quantity'] = quantity;
    data['stock'] = stock;
    return data;
  }
}
