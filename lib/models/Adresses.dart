class Adresses {
  bool success;
  List<Adress> data;
  String message;

  Adresses({this.success, this.data, this.message});

  Adresses.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <Adress>[];
      json['data'].forEach((v) {
        data.add(new Adress.fromJson(v));
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

class Adress {
  int id;
  String name;
  Null createdAt;
  Null updatedAt;
  int orderPrice;
  int minPrice;

  Adress({this.id, this.name, this.createdAt, this.updatedAt});

  Adress.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    minPrice = json['minPrice'];
    orderPrice = json['orderPrice'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['orderPrice'] = this.orderPrice;
    data['minPrice'] = this.minPrice;
    return data;
  }
}
