// To parse this JSON data, do
//
//     final productPage = productPageFromJson(jsonString);

import 'dart:convert';

ProductPage productPageFromJson(String str) => ProductPage.fromJson(json.decode(str));

String productPageToJson(ProductPage data) => json.encode(data.toJson());

class ProductPage {
  int id;
  String title;
  String description;
  String image;
  int price;
  int category;
  String brand;
  String brandLogo;
  String model;
  List<dynamic> images;

  ProductPage({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.price,
    required this.category,
    required this.brand,
    required this.brandLogo,
    required this.model,
    required this.images,
  });

  factory ProductPage.fromJson(Map<String, dynamic> json) => ProductPage(
    id: json["id"],
    title: json["title"],
    description: json["description"],
    image: json["image"],
    price: json["price"],
    category: json["category"],
    brand: json["brand"],
    brandLogo: json["brand_logo"],
    model: json["model"],
    images: List<dynamic>.from(json["images"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "image": image,
    "price": price,
    "category": category,
    "brand": brand,
    "brand_logo": brandLogo,
    "model": model,
    "images": List<dynamic>.from(images.map((x) => x)),
  };
}
