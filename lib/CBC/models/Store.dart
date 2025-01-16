// To parse this JSON data, do
//
//     final store = storeFromJson(jsonString);

import 'dart:convert';

Store storeFromJson(String str) => Store.fromJson(json.decode(str));

String storeToJson(Store data) => json.encode(data.toJson());

class Store {
  List<Story> stories;
  List<dynamic> ads;

  Store({
    required this.stories,
    required this.ads,
  });

  factory Store.fromJson(Map<String, dynamic> json) => Store(
    stories: List<Story>.from(json["stories"].map((x) => Story.fromJson(x))),
    ads: List<dynamic>.from(json["Ads"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "stories": List<dynamic>.from(stories.map((x) => x.toJson())),
    "Ads": List<dynamic>.from(ads.map((x) => x)),
  };
}

class Story {
  int id;
  String name;
  String logo;
  String description;
  String nameKur;
  int category;
  int city;
  int active;
  String facebook;
  String instagram;
  String telegram;
  String whatsapp;
  String discountCount;

  Story({
    required this.id,
    required this.name,
    required this.logo,
    required this.description,
    required this.nameKur,
    required this.category,
    required this.city,
    required this.active,
    required this.facebook,
    required this.instagram,
    required this.telegram,
    required this.whatsapp,
    required this.discountCount,
  });

  factory Story.fromJson(Map<String, dynamic> json) => Story(
    id: json["id"],
    name: json["name"],
    logo: json["logo"],
    description: json["description"],
    nameKur: json["name_kur"],
    category: json["category"],
    city: json["city"],
    active: json["active"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    telegram: json["telegram"],
    whatsapp: json["whatsapp"],
    discountCount: json["discountCount"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "logo": logo,
    "description": description,
    "name_kur": nameKur,
    "category": category,
    "city": city,
    "active": active,
    "facebook": facebook,
    "instagram": instagram,
    "telegram": telegram,
    "whatsapp": whatsapp,
    "discountCount": discountCount,
  };
}
