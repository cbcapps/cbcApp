// To parse this JSON data, do
//
//     final sale = saleFromJson(jsonString);

import 'dart:convert';

List<Sale> saleFromJson(String str) => List<Sale>.from(json.decode(str).map((x) => Sale.fromJson(x)));

String saleToJson(List<Sale> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Sale {
  int id;
  String name;
  String phone;
  String city;
  String address;
  int status;
  DateTime date;
  int price;
  int delivery;
  int userId;
  String title;
  String image;
  int bill;
  int count;
  int itemId;
  int priceItem;

  Sale({
    required this.id,
    required this.name,
    required this.phone,
    required this.city,
    required this.address,
    required this.status,
    required this.date,
    required this.price,
    required this.delivery,
    required this.userId,
    required this.title,
    required this.image,
    required this.bill,
    required this.count,
    required this.itemId,
    required this.priceItem,
  });

  factory Sale.fromJson(Map<String, dynamic> json) => Sale(
    id: json["id"],
    name: json["name"],
    phone: json["phone"],
    city: json["city"],
    address: json["address"],
    status: json["status"],
    date: DateTime.parse(json["date"]),
    price: json["price"],
    delivery: json["delivery"],
    userId: json["user_id"],
    title: json["title"],
    image: json["image"],
    bill: json["bill"],
    count: json["count"],
    itemId: json["item_id"],
    priceItem: json["price_item"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "phone": phone,
    "city": city,
    "address": address,
    "status": status,
    "date": date.toIso8601String(),
    "price": price,
    "delivery": delivery,
    "user_id": userId,
    "title": title,
    "image": image,
    "bill": bill,
    "count": count,
    "item_id": itemId,
    "price_item": priceItem,
  };
}
