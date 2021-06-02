class BusketItems {
  bool success;
  BusketStructure data;
  String message;

  BusketItems({this.success, this.data, this.message});

  BusketItems.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null
        ? new BusketStructure.fromJson(json['data'])
        : null;
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

class BusketStructure {
  List<BusketItem> basket;
  int allPrice;

  BusketStructure({this.basket, this.allPrice});

  BusketStructure.fromJson(Map<String, dynamic> json) {
    if (json['basket'] != null) {
      basket = new List<BusketItem>();
      json['basket'].forEach((v) {
        basket.add(new BusketItem.fromJson(v));
      });
    }
    allPrice = json['allPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.basket != null) {
      data['basket'] = this.basket.map((v) => v.toJson()).toList();
    }
    data['allPrice'] = this.allPrice;
    return data;
  }
}

class BusketItem {
  int id;
  String name;
  String images;
  String edMassa;
  String price;
  int catalogId;
  String content;
  String createdAt;
  String updatedAt;
  int amount;
  int basketId;

  BusketItem(
      {this.id,
      this.name,
      this.images,
      this.edMassa,
      this.price,
      this.catalogId,
      this.content,
      this.createdAt,
      this.updatedAt,
      this.amount,
      this.basketId});

  BusketItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    images = json['images'];
    edMassa = json['ed_massa'];
    price = json['price'];
    catalogId = json['catalog_id'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    amount = json['amount'];
    basketId = json['basket_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['images'] = this.images;
    data['ed_massa'] = this.edMassa;
    data['price'] = this.price;
    data['catalog_id'] = this.catalogId;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['amount'] = this.amount;
    data['basket_id'] = this.basketId;
    return data;
  }
}
