//class Products {
//  List<Product> data;
//
//  Products({this.data});
//
//  Products.fromJson(Map<String, dynamic> json) {
//    if (json['data'] != null) {
//      data = new List<Product>();
//      json['data'].forEach((v) {
//        data.add(new Product.fromJson(v));
//      });
//    }
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    if (this.data != null) {
//      data['data'] = this.data.map((v) => v.toJson()).toList();
//    }
//    return data;
//  }
//}
//
//class Product {
//  int id;
//  String image;
//  String name;
//  String path;
//  String price;
//  int catalogId;
//  String edMassa;
//  String content;
//  String createdAt;
//  String updatedAt;
//
//  Product(
//      {this.id,
//        this.image,
//        this.name,
//        this.path,
//        this.price,
//        this.catalogId,
//        this.edMassa,
//        this.content,
//        this.createdAt,
//        this.updatedAt});
//
//  Product.fromJson(Map<String, dynamic> json) {
//    id = json['id'];
//    image = json['image'];
//    name = json['name'];
//    path = json['path'];
//    price = json['price'];
//    catalogId = json['catalog_id'];
//    edMassa = json['ed_massa'];
//    content = json['content'];
//    createdAt = json['created_at'];
//    updatedAt = json['updated_at'];
//  }
//
//  Map<String, dynamic> toJson() {
//    final Map<String, dynamic> data = new Map<String, dynamic>();
//    data['id'] = this.id;
//    data['image'] = this.image;
//    data['name'] = this.name;
//    data['path'] = this.path;
//    data['price'] = this.price;
//    data['catalog_id'] = this.catalogId;
//    data['ed_massa'] = this.edMassa;
//    data['content'] = this.content;
//    data['created_at'] = this.createdAt;
//    data['updated_at'] = this.updatedAt;
//    return data;
//  }
//}