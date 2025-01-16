// To parse this JSON data, do
//
//     final categoryAll = categoryAllFromJson(jsonString);

import 'dart:convert';

List<CategoryAll> categoryAllFromJson(String str) => List<CategoryAll>.from(json.decode(str).map((x) => CategoryAll.fromJson(x)));

String categoryAllToJson(List<CategoryAll> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CategoryAll {
  int id;
  String title;
  String image;
  int active;
  int city;
  String cityTitle;

  CategoryAll({
    required this.id,
    required this.title,
    required this.image,
    required this.active,
    required this.city,
    required this.cityTitle,
  });

  factory CategoryAll.fromJson(Map<String, dynamic> json) => CategoryAll(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    active: json["active"],
    city: json["city"],
    cityTitle: json["city_title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "active": active,
    "city": city,
    "city_title": cityTitle,
  };
}
