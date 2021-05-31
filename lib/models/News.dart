class News {
  bool success;
  List<NewsSingle> data;
  String message;

  News({this.success, this.data, this.message});

  News.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    if (json['data'] != null) {
      data = new List<NewsSingle>();
      json['data'].forEach((v) {
        data.add(new NewsSingle.fromJson(v));
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

class NewsSingle {
  int id;
  String name;
  String content;
  String images;
  var createdAt;
  Null updatedAt;

  NewsSingle(
      {this.id,
        this.name,
        this.content,
        this.images,
        this.createdAt,
        this.updatedAt});

  NewsSingle.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    content = json['content'];
    images = json['images'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['content'] = this.content;
    data['images'] = this.images;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    return data;
  }
}