import 'dart:convert';

List<Discount> discountFromJsonDecode(dynamic extracted) =>
    List<Discount>.from(extracted.map((x) => Discount.fromJson(x)));
// List<Discount> discountOffersFromJson(String str) => List<Discount>.from(
//     json.decode(str).map((x) => Discount.fromJson(x)));
List<Discount> discountFromJson(String str) =>
    List<Discount>.from(json.decode(str).map((x) => Discount.fromJson(x)));
String discountToJson(List<Discount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Discount {
  int id;
  String store;
  double discount;
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
        discount: json["final_discount"] + 0.0 ?? 0.0,
        image: json["image"],
        storeId: json["storeId"],
      );

  /*
        {
      "id": 2693,
      "store": "توربان للحجابات",
      "discount": "50%",
      "image": "https://89.116.110.51:3000/uploads/1719588569614.jpg",
      "storeId": 709,
      "title": "الخصم على البضاعة الشتوية حصراً",
      "numeric_discount": 50
    },
      */
  /*
   {
    "id": 2172,
    "store": "Deniz perde",
    "discount": "خصم 15%",
    "image": "https://89.116.110.51:3000/uploads/1722658635723.jpeg",
    "storeId": 1518,
    "title": "اذا كانت الفاتورة اكثر من 500$"
  },
  */

  Map<String, dynamic> toJson() => {
        "id": id,
        "store": store,
        "discount": discount,
        "image": image,
        "storeId": storeId,
      };
}
