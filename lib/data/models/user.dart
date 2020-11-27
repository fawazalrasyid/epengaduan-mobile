import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());

class User {
  User({
    this.statusCode,
    this.message,
    this.data,
  });

  int statusCode;
  String message;
  Data data;

  factory User.fromJson(Map<String, dynamic> json) => User(
        statusCode: json["status_code"] == null ? null : json["status_code"],
        message: json["message"] == null ? null : json["message"],
        data: json["data"] == null ? null : Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "status_code": statusCode == null ? null : statusCode,
        "message": message == null ? null : message,
        "data": data == null ? null : data.toJson(),
      };
}

class Data {
  Data({
    this.nik,
    this.nama,
    this.username,
    this.password,
    this.telp,
    this.imagePath,
  });

  String nik;
  String nama;
  String username;
  String password;
  String telp;
  String imagePath;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        nik: json["nik"] == null ? null : json["nik"],
        nama: json["nama"] == null ? null : json["nama"],
        username: json["username"] == null ? null : json["username"],
        password: json["password"] == null ? null : json["password"],
        telp: json["telp"] == null ? null : json["telp"],
        imagePath: json["imagePath"] == null ? null : json["imagePath"],
      );

  Map<String, dynamic> toJson() => {
        "nik": nik == null ? null : nik,
        "nama": nama == null ? null : nama,
        "username": username == null ? null : username,
        "password": password == null ? null : password,
        "telp": telp == null ? null : telp,
        "imagePath": imagePath == null ? null : imagePath,
      };
}
