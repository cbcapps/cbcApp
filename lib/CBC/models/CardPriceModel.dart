List<CardPriceModel> cardPriceFromJson(dynamic extracted) =>
    List<CardPriceModel>.from(extracted.map((x) => CardPriceModel.fromJson(x)));

class CardPriceModel {
  int id;
  String price;
  String nameTxt;
  String isOrgnization;
  CardPriceModel({
    required this.id,
    required this.price,
    required this.nameTxt,
    required this.isOrgnization,
  });

  /*
  {
    "id": 1,
    "price": "75",
    "name": "بطاقة اشتراك فئة سنة واحدة",
    "expire_period": "1"
  },
  */
  factory CardPriceModel.fromJson(Map<String, dynamic> json) => CardPriceModel(
        id: json["id"],
        price: json["price"],
        nameTxt: json["name"],
        isOrgnization: json["isOrgniaztion"],
      );
}
