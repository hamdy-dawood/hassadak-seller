import 'package:hassadak_seller/constants/strings.dart';

class RegisterResponse {
  String? status;
  String? message;
  User? user;

  RegisterResponse({this.status, this.message, this.user});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    message = json['message'] ?? "";
    user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
}

class User {
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? telephone;
  String? whatsapp;
  String? facebookUrl;
  String? instaUrl;
  String? twitterUrl;
  String? description;
  String? role;
  List<dynamic>? likes;
  String? image;
  String? password;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  bool? active;
  String? sId;
  String? updatedAt;
  int? iV;

  User({
    this.firstName,
    this.lastName,
    this.email,
    this.username,
    this.telephone,
    this.whatsapp,
    this.facebookUrl,
    this.instaUrl,
    this.twitterUrl,
    this.description,
    this.role,
    this.likes,
    this.image,
    this.password,
    this.favouriteProduct,
    this.favouriteCompany,
    this.createdAt,
    this.active,
    this.sId,
    this.updatedAt,
    this.iV,
  });

  User.fromJson(Map<String, dynamic> json) {
    firstName = json['firstName'];
    lastName = json['lastName'];
    email = json['email'];
    username = json['username'];
    telephone = json['telephone'];
    whatsapp = json['whatsapp'];
    facebookUrl = json['facebookUrl'];
    instaUrl = json['instaUrl'];
    twitterUrl = json['twitterUrl'];
    description = json['description'];
    role = json['role'];
    likes = List.castFrom<dynamic, dynamic>(json['likes'] ?? []);
    image = json['image'] ?? UrlsStrings.noImageUrl;
    password = json['password'];
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
    createdAt = json['createdAt'];
    active = json['active'];
    sId = json['_id'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
}
