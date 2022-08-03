import 'dart:convert';
/// id : 125
/// total : "2455.00"
/// discount : "613.75"
/// subTotal : "1841.25"
/// status : "Pending"
/// items : [{"product":{"id":2,"category":1,"name":"Dalda Cooking Oil Tin","uom":"Ltr","weight":"5.000","price":"2455.00","expiry_date":null,"get_absolute_url":"/cooking-oil/dalda-cooking-oil-tin/","created_at":"2022-07-07T18:11:01.450537+05:00"},"quantity":1}]
/// user : {"username":"shakeeb","name":"Shakeeb Khan","family_members":4,"phone_number":"+923147896819","address":"Chungi #21, Multan","subsidy_amount":5000,"subsidy_percentage":25,"starting_date":"2022-06-27T20:16:58.864207+05:00","subsidy_date":"2022-06-27T20:16:58.883424+05:00"}


// {
// "id": 131,
// "total": "3619.00",
// "discount": "904.75",
// "subTotal": "2714.25",
// "status": "pending",
// "items": [
// {
// "product": {
// "id": 2,
// "category": 1,
// "name": "Dalda Cooking Oil Tin",
// "uom": "Ltr",
// "weight": "5.000",
// "price": "2455.00",
// "expiry_date": null,
// "get_absolute_url": "/cooking-oil/dalda-cooking-oil-tin/",
// "created_at": "2022-07-07T18:11:01.450537+05:00"
// },
// "quantity": 1
// },
// {
// "product": {
// "id": 1,
// "category": 1,
// "name": "Dalda Cooking Oil Pouch",
// "uom": "Ltr",
// "weight": "1.000",
// "price": "582.00",
// "expiry_date": null,
// "get_absolute_url": "/cooking-oil/dalda-cooking-oil-pouch/",
// "created_at": "2022-07-07T18:09:44.269232+05:00"
// },
// "quantity": 2
// }
// ],
// "user": {
// "username": "shakeeb",
// "name": "Shakeeb Khan",
// "family_members": 4,
// "phone_number": "+923147896819",
// "address": "Chungi #21, Multan",
// "subsidy_amount": 5000,
// "subsidy_percentage": 25,
// "starting_date": "2022-06-27T20:16:58.864207+05:00",
// "subsidy_date": "2022-06-27T20:16:58.883424+05:00"
// }
// }

NewOrdersModel newOrdersModelFromJson(String str) => NewOrdersModel.fromJson(json.decode(str));
String newOrdersModelToJson(NewOrdersModel data) => json.encode(data.toJson());
class NewOrdersModel {
  NewOrdersModel({
      int? id, 
      String? total, 
      String? discount, 
      String? subTotal,
      String? status,
      List<Items>? items, 
      User? user,}){
    _id = id;
    _total = total;
    _discount = discount;
    _subTotal = subTotal;
    _status = status;
    _items = items;
    _user = user;
}

  NewOrdersModel.fromJson(dynamic json) {
    _id = json['id'];
    _total = json['total'];
    _discount = json['discount'];
    _subTotal = json['subTotal'];
    _status = json['status'];
    if (json['items'] != null) {
      _items = [];
      json['items'].forEach((v) {
        _items?.add(Items.fromJson(v));
      });
    }
    _user = json['user'] != null ? User.fromJson(json['user']) : null;
  }
  int? _id;
  String? _total;
  String? _discount;
  String? _subTotal;
  String? _status;
  List<Items>? _items;
  User? _user;
NewOrdersModel copyWith({  int? id,
  String? total,
  String? discount,
  String? subTotal,
  String? status,
  List<Items>? items,
  User? user,
}) => NewOrdersModel(  id: id ?? _id,
  total: total ?? _total,
  discount: discount ?? _discount,
  subTotal: subTotal ?? _subTotal,
  status: status ?? _status,
  items: items ?? _items,
  user: user ?? _user,
);
  int? get id => _id;
  String? get total => _total;
  String? get discount => _discount;
  String? get subTotal => _subTotal;
  String? get status => _status;
  List<Items>? get items => _items;
  User? get user => _user;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['total'] = _total;
    map['discount'] = _discount;
    map['subTotal'] = _subTotal;
    map['stauts'] = _status;
    if (_items != null) {
      map['items'] = _items?.map((v) => v.toJson()).toList();
    }
    if (_user != null) {
      map['user'] = _user?.toJson();
    }
    return map;
  }

}

/// username : "shakeeb"
/// name : "Shakeeb Khan"
/// family_members : 4
/// phone_number : "+923147896819"
/// address : "Chungi #21, Multan"
/// subsidy_amount : 5000
/// subsidy_percentage : 25
/// starting_date : "2022-06-27T20:16:58.864207+05:00"
/// subsidy_date : "2022-06-27T20:16:58.883424+05:00"

User userFromJson(String str) => User.fromJson(json.decode(str));
String userToJson(User data) => json.encode(data.toJson());
class User {
  User({
      String? username, 
      String? name, 
      int? familyMembers, 
      String? phoneNumber, 
      String? address, 
      int? subsidyAmount, 
      int? subsidyPercentage, 
      String? startingDate, 
      String? subsidyDate,}){
    _username = username;
    _name = name;
    _familyMembers = familyMembers;
    _phoneNumber = phoneNumber;
    _address = address;
    _subsidyAmount = subsidyAmount;
    _subsidyPercentage = subsidyPercentage;
    _startingDate = startingDate;
    _subsidyDate = subsidyDate;
}

  User.fromJson(dynamic json) {
    _username = json['username'];
    _name = json['name'];
    _familyMembers = json['family_members'];
    _phoneNumber = json['phone_number'];
    _address = json['address'];
    _subsidyAmount = json['subsidy_amount'];
    _subsidyPercentage = json['subsidy_percentage'];
    _startingDate = json['starting_date'];
    _subsidyDate = json['subsidy_date'];
  }
  String? _username;
  String? _name;
  int? _familyMembers;
  String? _phoneNumber;
  String? _address;
  int? _subsidyAmount;
  int? _subsidyPercentage;
  String? _startingDate;
  String? _subsidyDate;
User copyWith({  String? username,
  String? name,
  int? familyMembers,
  String? phoneNumber,
  String? address,
  int? subsidyAmount,
  int? subsidyPercentage,
  String? startingDate,
  String? subsidyDate,
}) => User(  username: username ?? _username,
  name: name ?? _name,
  familyMembers: familyMembers ?? _familyMembers,
  phoneNumber: phoneNumber ?? _phoneNumber,
  address: address ?? _address,
  subsidyAmount: subsidyAmount ?? _subsidyAmount,
  subsidyPercentage: subsidyPercentage ?? _subsidyPercentage,
  startingDate: startingDate ?? _startingDate,
  subsidyDate: subsidyDate ?? _subsidyDate,
);
  String? get username => _username;
  String? get name => _name;
  int? get familyMembers => _familyMembers;
  String? get phoneNumber => _phoneNumber;
  String? get address => _address;
  int? get subsidyAmount => _subsidyAmount;
  int? get subsidyPercentage => _subsidyPercentage;
  String? get startingDate => _startingDate;
  String? get subsidyDate => _subsidyDate;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['username'] = _username;
    map['name'] = _name;
    map['family_members'] = _familyMembers;
    map['phone_number'] = _phoneNumber;
    map['address'] = _address;
    map['subsidy_amount'] = _subsidyAmount;
    map['subsidy_percentage'] = _subsidyPercentage;
    map['starting_date'] = _startingDate;
    map['subsidy_date'] = _subsidyDate;
    return map;
  }

}

/// product : {"id":2,"category":1,"name":"Dalda Cooking Oil Tin","uom":"Ltr","weight":"5.000","price":"2455.00","expiry_date":null,"get_absolute_url":"/cooking-oil/dalda-cooking-oil-tin/","created_at":"2022-07-07T18:11:01.450537+05:00"}
/// quantity : 1

Items itemsFromJson(String str) => Items.fromJson(json.decode(str));
String itemsToJson(Items data) => json.encode(data.toJson());
class Items {
  Items({
      Product? product, 
      int? quantity,}){
    _product = product;
    _quantity = quantity;
}

  Items.fromJson(dynamic json) {
    _product = json['product'] != null ? Product.fromJson(json['product']) : null;
    _quantity = json['quantity'];

  }
  Product? _product;
  int? _quantity;
Items copyWith({  Product? product,
  int? quantity,
}) => Items(  product: product ?? _product,
  quantity: quantity ?? _quantity,
);
  Product? get product => _product;
  int? get quantity => _quantity;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (_product != null) {
      map['product'] = _product?.toJson();
    }
    map['quantity'] = _quantity;
    return map;
  }

}

/// id : 2
/// category : 1
/// name : "Dalda Cooking Oil Tin"
/// uom : "Ltr"
/// weight : "5.000"
/// price : "2455.00"
/// expiry_date : null
/// get_absolute_url : "/cooking-oil/dalda-cooking-oil-tin/"
/// created_at : "2022-07-07T18:11:01.450537+05:00"

Product productFromJson(String str) => Product.fromJson(json.decode(str));
String productToJson(Product data) => json.encode(data.toJson());
class Product {
  Product({
      int? id, 
      int? category, 
      String? name, 
      String? uom, 
      String? weight, 
      String? price, 
      dynamic expiryDate, 
      String? getAbsoluteUrl, 
      String? createdAt,}){
    _id = id;
    _category = category;
    _name = name;
    _uom = uom;
    _weight = weight;
    _price = price;
    _expiryDate = expiryDate;
    _getAbsoluteUrl = getAbsoluteUrl;
    _createdAt = createdAt;
}

  Product.fromJson(dynamic json) {
    _id = json['id'];
    _category = json['category'];
    _name = json['name'];
    _uom = json['uom'];
    _weight = json['weight'];
    _price = json['price'];
    _expiryDate = json['expiry_date'];
    _getAbsoluteUrl = json['get_absolute_url'];
    _createdAt = json['created_at'];
  }
  int? _id;
  int? _category;
  String? _name;
  String? _uom;
  String? _weight;
  String? _price;
  dynamic _expiryDate;
  String? _getAbsoluteUrl;
  String? _createdAt;
Product copyWith({  int? id,
  int? category,
  String? name,
  String? uom,
  String? weight,
  String? price,
  dynamic expiryDate,
  String? getAbsoluteUrl,
  String? createdAt,
}) => Product(  id: id ?? _id,
  category: category ?? _category,
  name: name ?? _name,
  uom: uom ?? _uom,
  weight: weight ?? _weight,
  price: price ?? _price,
  expiryDate: expiryDate ?? _expiryDate,
  getAbsoluteUrl: getAbsoluteUrl ?? _getAbsoluteUrl,
  createdAt: createdAt ?? _createdAt,
);
  int? get id => _id;
  int? get category => _category;
  String? get name => _name;
  String? get uom => _uom;
  String? get weight => _weight;
  String? get price => _price;
  dynamic get expiryDate => _expiryDate;
  String? get getAbsoluteUrl => _getAbsoluteUrl;
  String? get createdAt => _createdAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['category'] = _category;
    map['name'] = _name;
    map['uom'] = _uom;
    map['weight'] = _weight;
    map['price'] = _price;
    map['expiry_date'] = _expiryDate;
    map['get_absolute_url'] = _getAbsoluteUrl;
    map['created_at'] = _createdAt;
    return map;
  }

}