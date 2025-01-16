import 'dart:convert';
List<Discount> discountFromJson(String str) => List<Discount>.from(json.decode(str).map((x) => Discount.fromJson(x)));
String discountToJson(List<Discount> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class Discount {
  int id;
  String store;
  String discount;
  String image;
  int storeId;
  Discount({
    required this.id,
    required this.store,
    required this.discount,
    required this.image,
    required this.storeId,
  });
  factory Discount.fromJson(Map<String, dynamic> json) => Discount(
    id: json["id"],
    store: json["store"],
    discount: json["discount"],
    image: json["image"],
    storeId: json["storeId"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "store": store,
    "discount": discount,
    "image": image,
    "storeId": storeId,
  };
}
