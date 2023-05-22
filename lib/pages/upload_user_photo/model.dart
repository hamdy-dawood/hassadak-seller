import 'package:hassadak_seller/constants/strings.dart';

class UploadUserPhotoRepo {
  String? status;
  UpdatedUser? updatedUser;

  UploadUserPhotoRepo({this.status, this.updatedUser});

  UploadUserPhotoRepo.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    updatedUser = json['updatedUser'] != null
        ? UpdatedUser.fromJson(json['updatedUser'])
        : null;
  }
}

class UpdatedUser {
  String? sId;
  String? firstName;
  String? lastName;
  String? email;
  String? username;
  String? telephone;
  String? role;
  List<dynamic>? likes;
  String? image;
  List<dynamic>? favouriteProduct;
  List<dynamic>? favouriteCompany;
  String? createdAt;
  String? updatedAt;
  int? iV;
  String? cloudinaryId;
  String? userPhoto;

  UpdatedUser(
      {this.sId,
      this.firstName,
      this.lastName,
      this.email,
      this.username,
      this.telephone,
      this.role,
      this.likes,
      this.image,
      this.favouriteProduct,
      this.favouriteCompany,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.cloudinaryId,
      this.userPhoto});

  UpdatedUser.fromJson(Map<String, dynamic> json) {
    sId = json['_id'] ?? "";
    firstName = json['firstName'] ?? "";
    lastName = json['lastName'] ?? "";
    email = json['email'] ?? "";
    username = json['username'] ?? "";
    telephone = json['telephone'] ?? "";
    role = json['role'] ?? "";
    likes = List.castFrom<dynamic, dynamic>(json['likes'] ?? []);
    image = json['image'] ?? UrlsStrings.userImageUrl;
    favouriteProduct =
        List.castFrom<dynamic, dynamic>(json['favouriteProduct'] ?? []);
    favouriteCompany =
        List.castFrom<dynamic, dynamic>(json['favouriteCompany'] ?? []);
    createdAt = json['createdAt'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    iV = json['__v'] ?? "";
    cloudinaryId = json['cloudinaryId'] ?? "";
    userPhoto = json['userPhoto'] ?? UrlsStrings.userImageUrl;
  }
}
