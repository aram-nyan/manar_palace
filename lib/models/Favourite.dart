class Favourite {
  bool success;
  List<FavouriteItem> data;
  String message;

  Favourite({this.success, this.data, this.message});

  Favourite.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<FavouriteItem>();
      json['data'].forEach((v) {
        data.add(new FavouriteItem.fromJson(v));
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

class FavouriteItem {
  int id;
  String images;
  String title;
  String content;
  String edMassa;
  int edMassa2;
  int edCount;
  int let;
  Null tags;
  String price;
  Null size;
  String slug;
  String path;
  String createdAt;
  String updatedAt;
  int catalogId;
  int favoritId;

  FavouriteItem(
      {this.id,
      this.images,
      this.title,
      this.content,
      this.edMassa,
      this.edMassa2,
      this.edCount,
      this.let,
      this.tags,
      this.price,
      this.size,
      this.slug,
      this.path,
      this.createdAt,
      this.updatedAt,
      this.catalogId,
      this.favoritId});

  FavouriteItem.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    images = json['images'];
    title = json['title'];
    content = json['content'];
    edMassa = json['ed_massa'];
    edMassa2 = json['ed_massa2'];
    edCount = json['ed_count'];
    let = json['let'];
    tags = json['tags'];
    price = json['price'];
    size = json['size'];
    slug = json['slug'];
    path = json['path'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    catalogId = json['catalog_id'];
    favoritId = json['favorit_id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['images'] = this.images;
    data['title'] = this.title;
    data['content'] = this.content;
    data['ed_massa'] = this.edMassa;
    data['ed_massa2'] = this.edMassa2;
    data['ed_count'] = this.edCount;
    data['let'] = this.let;
    data['tags'] = this.tags;
    data['price'] = this.price;
    data['size'] = this.size;
    data['slug'] = this.slug;
    data['path'] = this.path;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['catalog_id'] = this.catalogId;
    data['favorit_id'] = this.favoritId;
    return data;
  }
}
