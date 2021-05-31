class UserObj {
  bool success;
  User data;
  String message;

  UserObj({this.success, this.data, this.message});

  UserObj.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    data = json['data'] != null ? new User.fromJson(json['data']) : null;
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

class User {
  String token;
  String name;
  String email;
  String tel;
  String address;
  String apartment;
  String entrance;
  String district;

  User(
      {this.token,
        this.name,
        this.email,
        this.tel,
        this.address,
        this.apartment,
        this.entrance,
        this.district});

  User.fromJson(Map<String, dynamic> json) {
    token = json['token'];
    name = json['name'];
    email = json['email'];
    tel = json['tel'];
    address = json['address'];
    apartment = json['apartment'];
    entrance = json['entrance'];
    district = json['district'];
  }
  Map toMyJson() => {
    'name': name,
    'address': address,
    'email': email,
    'district': district,
    'appartment': apartment,
    'tel': tel,
    'token': token,
    'entrance':entrance,
  };

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['token'] = this.token;
    data['name'] = this.name;
    data['email'] = this.email;
    data['tel'] = this.tel;
    data['address'] = this.address;
    data['apartment'] = this.apartment;
    data['entrance'] = this.entrance;
    data['district'] = this.district;
    return data;
  }
}