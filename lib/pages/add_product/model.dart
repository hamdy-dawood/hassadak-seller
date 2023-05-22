class CreateProductResp {
  String? status;
  NewProduct? newProduct;

  CreateProductResp({this.status, this.newProduct});

  CreateProductResp.fromJson(Map<String, dynamic> json) {
    status = json['status'] ?? "";
    newProduct = json['newProduct'] != null
        ? NewProduct.fromJson(json['newProduct'] ?? Map<String, dynamic>)
        : null;
  }
}

class NewProduct {
  String? name;
  String? desc;
  String? typeId;
  String? categoryId;
  String? productUrl;
  num? ratingsAverage;
  num? ratingsQuantity;
  num? price;
  String? discount;
  num? discountPerc;
  String? uploaderId;
  String? uploaderName;
  String? createdAt;
  String? sId;
  String? updatedAt;
  num? iV;
  String? id;

  NewProduct(
      {this.name,
      this.desc,
      this.typeId,
      this.categoryId,
      this.productUrl,
      this.ratingsAverage,
      this.ratingsQuantity,
      this.price,
      this.discount,
      this.discountPerc,
      this.uploaderId,
      this.uploaderName,
      this.createdAt,
      this.sId,
      this.updatedAt,
      this.iV,
      this.id});

  NewProduct.fromJson(Map<String, dynamic> json) {
    name = json['name'] ?? "لا يوجد";
    desc = json['desc'] ?? "";
    typeId = json['typeId'] ?? "";
    categoryId = json['categoryId'] ?? "";
    productUrl = json['productUrl'] ?? "";
    ratingsAverage = json['ratingsAverage'] ?? 0;
    ratingsQuantity = json['ratingsQuantity'] ?? 0;
    price = json['price'] ?? 0;
    discount = json['discount'] ?? "";
    discountPerc = json['discountPerc'] ?? 0;
    uploaderId = json['uploaderId'] ?? "";
    uploaderName = json['uploaderName'] ?? "";
    createdAt = json['createdAt'] ?? "";
    sId = json['_id'] ?? "";
    updatedAt = json['updatedAt'] ?? "";
    iV = json['__v'] ?? 0;
    id = json['id'] ?? "";
  }
}
