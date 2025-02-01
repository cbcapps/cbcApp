import 'dart:convert';

List<RecentlyDiscount> recentlDiscountFromJsonDecode(dynamic extracted) =>
    List<RecentlyDiscount>.from(
        extracted.map((x) => RecentlyDiscount.fromJson(x)));
// List<Discount> discountOffersFromJson(String str) => List<Discount>.from(
//     json.decode(str).map((x) => Discount.fromJson(x)));
List<RecentlyDiscount> discountFromJson(String str) =>
    List<RecentlyDiscount>.from(
        json.decode(str).map((x) => RecentlyDiscount.fromJson(x)));
String discountToJson(List<RecentlyDiscount> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RecentlyDiscount {
  int id;
  String store;
  String discount;
  String image;
  int storeId;
  RecentlyDiscount({
    required this.id,
    required this.store,
    required this.discount,
    required this.image,
    required this.storeId,
  });
  factory RecentlyDiscount.fromJson(Map<String, dynamic> json) =>
      RecentlyDiscount(
        id: json["id"],
        store: json["store"],
        discount: json["discount"] ?? '',
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
