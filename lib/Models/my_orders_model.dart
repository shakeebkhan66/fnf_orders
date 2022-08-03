// To parse this JSON data, do
//
//     final ordersModel = ordersModelFromJson(jsonString);

import 'dart:convert';

List<OrdersModel> ordersModelFromJson(String str) => List<OrdersModel>.from(json.decode(str).map((x) => OrdersModel.fromJson(x)));

String ordersModelToJson(List<OrdersModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class OrdersModel {
  OrdersModel({
    required this.id,
    required this.total,
    required this.discount,
    required this.subTotal,
    required this.status,
    required this.items,
    required this.user,
  });

  int id;
  String total;
  String discount;
  String subTotal;
  Status? status;
  List<Item> items;
  User user;

  factory OrdersModel.fromJson(Map<String, dynamic> json) => OrdersModel(
    id: json["id"],
    total: json["total"],
    discount: json["discount"],
    subTotal: json["subTotal"],
    status: statusValues.map[json["status"]],
    items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "total": total,
    "discount": discount,
    "subTotal": subTotal,
    "status": statusValues.reverse![status],
    "items": List<dynamic>.from(items.map((x) => x.toJson())),
    "user": user.toJson(),
  };
}

class Item {
  Item({
    required this.product,
    required this.quantity,
  });

  Product product;
  int quantity;

  factory Item.fromJson(Map<String, dynamic> json) => Item(
    product: Product.fromJson(json["product"]),
    quantity: json["quantity"],
  );

  Map<String, dynamic> toJson() => {
    "product": product.toJson(),
    "quantity": quantity,
  };
}

class Product {
  Product({
    required this.id,
    required this.category,
    required this.name,
    required this.uom,
    required this.weight,
    required this.price,
    this.expiryDate,
    required this.getAbsoluteUrl,
    required this.createdAt,
  });

  int id;
  int category;
  ProductName? name;
  Uom? uom;
  String weight;
  String price;
  dynamic expiryDate;
  GetAbsoluteUrl? getAbsoluteUrl;
  DateTime createdAt;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
    id: json["id"],
    category: json["category"],
    name: productNameValues.map[json["name"]],
    uom: uomValues.map[json["uom"]],
    weight: json["weight"],
    price: json["price"],
    expiryDate: json["expiry_date"],
    getAbsoluteUrl: getAbsoluteUrlValues.map[json["get_absolute_url"]],
    createdAt: DateTime.parse(json["created_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "category": category,
    "name": productNameValues.reverse![name],
    "uom": uomValues.reverse![uom],
    "weight": weight,
    "price": price,
    "expiry_date": expiryDate,
    "get_absolute_url": getAbsoluteUrlValues.reverse![getAbsoluteUrl],
    "created_at": createdAt.toIso8601String(),
  };
}

enum GetAbsoluteUrl { COOKING_OIL_TULLO_COOKING_OIL_POUCH, COOKING_OIL_DALDA_COOKING_OIL_TIN, COOKING_OIL_DALDA_COOKING_OIL_POUCH }

final getAbsoluteUrlValues = EnumValues({
  "/cooking-oil/dalda-cooking-oil-pouch/": GetAbsoluteUrl.COOKING_OIL_DALDA_COOKING_OIL_POUCH,
  "/cooking-oil/dalda-cooking-oil-tin/": GetAbsoluteUrl.COOKING_OIL_DALDA_COOKING_OIL_TIN,
  "/cooking-oil/tullo-cooking-oil-pouch/": GetAbsoluteUrl.COOKING_OIL_TULLO_COOKING_OIL_POUCH
});

enum ProductName { TULLO_COOKING_OIL_POUCH, DALDA_COOKING_OIL_TIN, DALDA_COOKING_OIL_POUCH }

final productNameValues = EnumValues({
  "Dalda Cooking Oil Pouch": ProductName.DALDA_COOKING_OIL_POUCH,
  "Dalda Cooking Oil Tin": ProductName.DALDA_COOKING_OIL_TIN,
  "Tullo Cooking Oil Pouch": ProductName.TULLO_COOKING_OIL_POUCH
});

enum Uom { LTR }

final uomValues = EnumValues({
  "Ltr": Uom.LTR
});

enum Status { PENDING, RECEIVED }

final statusValues = EnumValues({
  "pending": Status.PENDING,
  "received": Status.RECEIVED
});

class User {
  User({
    required this.username,
    required this.name,
    required this.familyMembers,
    required this.phoneNumber,
    required this.address,
    required this.subsidyAmount,
    required this.subsidyPercentage,
    required this.startingDate,
    required this.subsidyDate,
  });

  Username? username;
  UserName? name;
  int familyMembers;
  String phoneNumber;
  Address? address;
  int subsidyAmount;
  int subsidyPercentage;
  DateTime startingDate;
  DateTime subsidyDate;

  factory User.fromJson(Map<String, dynamic> json) => User(
    username: usernameValues.map[json["username"]],
    name: userNameValues.map[json["name"]],
    familyMembers: json["family_members"],
    phoneNumber: json["phone_number"],
    address: addressValues.map[json["address"]],
    subsidyAmount: json["subsidy_amount"],
    subsidyPercentage: json["subsidy_percentage"],
    startingDate: DateTime.parse(json["starting_date"]),
    subsidyDate: DateTime.parse(json["subsidy_date"]),
  );

  Map<String, dynamic> toJson() => {
    "username": usernameValues.reverse![username],
    "name": userNameValues.reverse![name],
    "family_members": familyMembers,
    "phone_number": phoneNumber,
    "address": addressValues.reverse![address],
    "subsidy_amount": subsidyAmount,
    "subsidy_percentage": subsidyPercentage,
    "starting_date": startingDate.toIso8601String(),
    "subsidy_date": subsidyDate.toIso8601String(),
  };
}

enum Address { CHUNGI_21_MULTAN }

final addressValues = EnumValues({
  "Chungi #21, Multan": Address.CHUNGI_21_MULTAN
});

enum UserName { SHAKEEB_KHAN }

final userNameValues = EnumValues({
  "Shakeeb Khan": UserName.SHAKEEB_KHAN
});

enum Username { SHAKEEB }

final usernameValues = EnumValues({
  "shakeeb": Username.SHAKEEB
});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
