class HistoryOrders {
  bool success;
  List<Data> data;
  String message;

  HistoryOrders({this.success, this.data, this.message});

  HistoryOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<Data>();
      json['data'].forEach((v) {
        data.add(new Data.fromJson(v));
      });
    }
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.map((v) => v.toJson()).toList();
    }
    data['message'] = this.message;
    return data;
  }
}

class Data {
  int id;
  String images;
  String name;
  int price;
  String content;
  int amount;
  int allPrice;
  String productId;
  String createdAt;

  Data(
      {this.id,
        this.images,
        this.name,
        this.price,
        this.amount,
        this.allPrice,
        this.content,
        this.productId,
        this.createdAt});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    name = json['name'];
    price = json['price'];
    amount = json['amount'];
    content = json['content'];
    allPrice = json['allPrice'];
    productId = json['product_id'];
    createdAt = json['created_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['name'] = this.name;
    data['price'] = this.price;
    data['content'] = this.content;
    data['amount'] = this.amount;
    data['allPrice'] = this.allPrice;
    data['product_id'] = this.productId;
    data['created_at'] = this.createdAt;
    return data;
  }
}