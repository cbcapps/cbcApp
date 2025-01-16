// To parse this JSON data, do
//
//     final subCategory = subCategoryFromJson(jsonString);

import 'dart:convert';

List<SubCategory> subCategoryFromJson(String str) => List<SubCategory>.from(json.decode(str).map((x) => SubCategory.fromJson(x)));

String subCategoryToJson(List<SubCategory> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCategory {
  int id;
  String title;
  int category;
  String image;

  SubCategory({
    required this.id,
    required this.title,
    required this.category,
    required this.image,
  });

  factory SubCategory.fromJson(Map<String, dynamic> json) => SubCategory(
    id: json["id"],
    title: json["title"],
    category: json["category"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "category": category,
    "image": image,
  };
}
