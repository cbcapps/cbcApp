List<ShoppingModel> shoppingModelFromJson(dynamic extracted) =>
    List<ShoppingModel>.from(extracted.map((x) => ShoppingModel.fromJson(x)));

class ShoppingModel {
  int id;
  int isFavorite;
  String name;
  String logo;

  String? facebook;
  String? instagram;

  String discountCount;

  ShoppingModel({
    required this.id,
    required this.isFavorite,
    required this.name,
    required this.logo,
    required this.facebook,
    required this.instagram,
    required this.discountCount,
  });

  factory ShoppingModel.fromJson(Map<String, dynamic> json) => ShoppingModel(
        id: json["id"],
        name: json["name"],
        logo: json["imgPath"],
        facebook: json["facebook"],
        instagram: json["instagram"],
        isFavorite: json["favoriteStatus"],
        discountCount: json["discount"].toString(),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "logo": logo,
        "facebook": facebook,
        "instagram": instagram,
        "discountCount": discountCount,
      };

  // end Class
}
