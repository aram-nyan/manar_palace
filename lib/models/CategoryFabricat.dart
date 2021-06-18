class FabricatAll {
  bool success;
  List<CategoriesModelFabricat> data;
  String message;

  FabricatAll({this.success, this.data, this.message});

  FabricatAll.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = <CategoriesModelFabricat>[];
      json['data'].forEach((v) {
        data.add(new CategoriesModelFabricat.fromJson(v));
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

class CategoriesModelFabricat {
  CategoriesFabrikat categories;
  String categoryName;

  CategoriesModelFabricat({this.categories, this.categoryName});

  CategoriesModelFabricat.fromJson(Map<String, dynamic> json) {
    categories = json['categories'] != null
        ? new CategoriesFabrikat.fromJson(json['categories'])
        : null;
    categoryName = json['categoryName'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.categories != null) {
      data['categories'] = this.categories.toJson();
    }
    data['categoryName'] = this.categoryName;
    return data;
  }
}

class CategoriesFabrikat {
  dynamic id;
  dynamic title;
  dynamic slug;
  dynamic path;
  dynamic content;
  dynamic iLft;
  dynamic iRgt;
  dynamic parentId;
  dynamic createdAt;
  dynamic updatedAt;
  dynamic sort;
  dynamic visable;
  List<ProductModelFabrikat> products;

  CategoriesFabrikat(
      {this.id,
      this.title,
      this.slug,
      this.path,
      this.content,
      this.iLft,
      this.iRgt,
      this.parentId,
      this.createdAt,
      this.updatedAt,
      this.sort,
      this.visable,
      this.products});

  CategoriesFabrikat.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    slug = json['slug'];
    path = json['path'];
    content = json['content'];
    iLft = json['_lft'];
    iRgt = json['_rgt'];
    parentId = json['parent_id'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    sort = json['sort'];
    visable = json['visable'];
    if (json['products'] != null) {
      products = <ProductModelFabrikat>[];
      json['products'].forEach((v) {
        products.add(new ProductModelFabrikat.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['slug'] = this.slug;
    data['path'] = this.path;
    data['content'] = this.content;
    data['_lft'] = this.iLft;
    data['_rgt'] = this.iRgt;
    data['parent_id'] = this.parentId;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['sort'] = this.sort;
    data['visable'] = this.visable;
    if (this.products != null) {
      data['products'] = this.products.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ProductModelFabrikat {
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

  ProductModelFabrikat(
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
      this.catalogId});

  ProductModelFabrikat.fromJson(Map<String, dynamic> json) {
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
    return data;
  }
}
