class Order {
  bool success;
  OrderTable data;
  int message;

  Order({this.success, this.data, this.message});

  Order.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new OrderTable.fromJson(json['data']) : null;
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    if (this.data != null) {
      data['data'] = this.data.toJson();
    }
    data['message'] = this.message;
    return data;
  }
}

class OrderTable {
  int orderNumber;
  String price;
  int priceOld;
  String status;
  int userId;
  String updatedAt;
  String createdAt;
  int id;

  OrderTable(
      {this.orderNumber,
        this.price,
        this.priceOld,
        this.status,
        this.userId,
        this.updatedAt,
        this.createdAt,
        this.id});

  OrderTable.fromJson(Map<String, dynamic> json) {
    orderNumber = json['order_number'];
    price = json['price'];
    priceOld = json['price_old'];
    status = json['status'];
    userId = json['User_id'];
    updatedAt = json['updated_at'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['order_number'] = this.orderNumber;
    data['price'] = this.price;
    data['price_old'] = this.priceOld;
    data['status'] = this.status;
    data['User_id'] = this.userId;
    data['updated_at'] = this.updatedAt;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}