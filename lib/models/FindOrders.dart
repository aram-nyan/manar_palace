class FindOrders {
  bool success;
  List<FindITem> data;
  String message;

  FindOrders({this.success, this.data, this.message});

  FindOrders.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<FindITem>();
      json['data'].forEach((v) {
        data.add(new FindITem.fromJson(v));
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

class FindITem {
  int id;
  String image;
  String name;
  String path;
  String price;
  int catalogId;
  String edMassa;
  String content;
  String createdAt;
  String updatedAt;

  FindITem(
      {this.id,
      this.image,
      this.name,
      this.path,
      this.price,
      this.catalogId,
      this.edMassa,
      this.content,
      this.createdAt,
      this.updatedAt});

  FindITem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
    name = json['name'];
    path = json['path'];
    price = json['price'];
    catalogId = json['catalog_id'];
    edMassa = json['ed_massa'];
    content = json['content'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image'] = this.image;
    data['name'] = this.name;
    data['path'] = this.path;
    data['price'] = this.price;
    data['catalog_id'] = this.catalogId;
    data['ed_massa'] = this.edMassa;
    data['content'] = this.content;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}
