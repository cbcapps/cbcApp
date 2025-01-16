import 'dart:convert';

CardType cardTypeFromJson(String str) => CardType.fromJson(json.decode(str));
String cardTypeToJson(CardType data) => json.encode(data.toJson());

class CardType {
  List<Type> type;

  CardType({
    required this.type,
  });

  factory CardType.fromJson(Map<String, dynamic> json) => CardType(
    type: List<Type>.from(json["type"].map((x) => Type.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "type": List<dynamic>.from(type.map((x) => x.toJson())),
  };
}

class Type {
  int id;
  String type;
  int price;

  Type({
    required this.id,
    required this.type,
    required this.price,
  });

  factory Type.fromJson(Map<String, dynamic> json) => Type(
    id: json["id"],
    type: json["type"],
    price: json["price"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "type": type,
    "price": price,
  };
}
