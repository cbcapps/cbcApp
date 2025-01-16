
import 'dart:convert';
StoreModel storeModelFromJson(String str) => StoreModel.fromJson(json.decode(str));
String storeModelToJson(StoreModel data) => json.encode(data.toJson());

class StoreModel {
  Storeinfo storeinfo;

  StoreModel({
    required this.storeinfo,
  });

  factory StoreModel.fromJson(Map<String, dynamic> json) => StoreModel(
    storeinfo: Storeinfo.fromJson(json["storeinfo"]),
  );

  Map<String, dynamic> toJson() => {
    "storeinfo": storeinfo.toJson(),
  };
}

class Storeinfo {
  int id;
  String name;
  String logo;
  String description;
  String nameKur;
  String categoryName;
  int category;
  int city;
  String facebook;
  String instagram;
  String telegram;
  String whatsapp;
  int active;
  List<String> sliders;
  List<dynamic> images;
  List<Branch> branches;
  List<dynamic> offers;
  List<DiscountModel> discounts;

  Storeinfo({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.nameKur,
    required this.category,
    required this.city,
    required this.facebook,
    required this.instagram,
    required this.telegram,
    required this.whatsapp,
    required this.active,
    required this.sliders,
    required this.images,
    required this.branches,
    required this.offers,
    required this.discounts,
    required this.categoryName
  });

  factory Storeinfo.fromJson(Map<String, dynamic> json) => Storeinfo(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    nameKur: json["name_kur"],
    category: json["category"],
    city: json["city"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    telegram: json["telegram"],
    whatsapp: json["whatsapp"],
    active: json["active"],
    categoryName: json["categoryName"],
    sliders: List<String>.from(json["sliders"].map((x) => x)),
    images: List<dynamic>.from(json["images"].map((x) => x)),
    branches: List<Branch>.from(json["branches"].map((x) => Branch.fromJson(x))),
    offers: List<dynamic>.from(json["offers"].map((x) => x)),
    discounts: List<DiscountModel>.from(json["discounts"].map((x) => DiscountModel.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "description": description,
    "name_kur": nameKur,
    "category": category,
    "city": city,
    "facebook": facebook,
    "instagram": instagram,
    "telegram": telegram,
    "whatsapp": whatsapp,
    "active": active,
    "categoryName": categoryName,
    "sliders": List<dynamic>.from(sliders.map((x) => x)),
    "images": List<dynamic>.from(images.map((x) => x)),
    "branches": List<dynamic>.from(branches.map((x) => x.toJson())),
    "offers": List<dynamic>.from(offers.map((x) => x)),
    "discounts": List<dynamic>.from(discounts.map((x) => x.toJson())),
  };
}

class Branch {
  String title;
  String phone;
  String location;

  Branch({
    required this.title,
    required this.phone,
    required this.location,
  });

  factory Branch.fromJson(Map<String, dynamic> json) => Branch(
    title: json["title"],
    phone: json["phone"],
    location: json["location"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "phone": phone,
    "location": location,
  };
}

class DiscountModel {
  String title;
  String discount;

  DiscountModel({
    required this.title,
    required this.discount,
  });

  factory DiscountModel.fromJson(Map<String, dynamic> json) => DiscountModel(
    title: json["title"],
    discount: json["discount"],
  );

  Map<String, dynamic> toJson() => {
    "title": title,
    "discount": discount,
  };
}
