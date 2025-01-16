import 'dart:convert';
CardSale cardSaleFromJson(String str) => CardSale.fromJson(json.decode(str));

String cardSaleToJson(CardSale data) => json.encode(data.toJson());

class CardSale {
  List<CitiesWithSale> citiesWithSales;
  Systeminfo systeminfo;

  CardSale({
    required this.citiesWithSales,
    required this.systeminfo,
  });

  factory CardSale.fromJson(Map<String, dynamic> json) => CardSale(
    citiesWithSales: List<CitiesWithSale>.from(json["citiesWithSales"].map((x) => CitiesWithSale.fromJson(x))),
    systeminfo: Systeminfo.fromJson(json["systeminfo"]),
  );

  Map<String, dynamic> toJson() => {
    "citiesWithSales": List<dynamic>.from(citiesWithSales.map((x) => x.toJson())),
    "systeminfo": systeminfo.toJson(),
  };
}

class CitiesWithSale {
  int id;
  String title;
  List<SalesInfo> salesInfo;

  CitiesWithSale({
    required this.id,
    required this.title,
    required this.salesInfo,
  });

  factory CitiesWithSale.fromJson(Map<String, dynamic> json) => CitiesWithSale(
    id: json["id"],
    title: json["title"],
    salesInfo: List<SalesInfo>.from(json["sales_info"].map((x) => SalesInfo.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "sales_info": List<dynamic>.from(salesInfo.map((x) => x.toJson())),
  };
}

class SalesInfo {
  String name;
  String phone;
  String image;

  SalesInfo({
    required this.name,
    required this.phone,
    required this.image,
  });

  factory SalesInfo.fromJson(Map<String, dynamic> json) => SalesInfo(
    name: json["name"],
    phone: json["phone"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "name": name,
    "phone": phone,
    "image": image,
  };
}

class Systeminfo {
  String phone;

  Systeminfo({
    required this.phone,
  });

  factory Systeminfo.fromJson(Map<String, dynamic> json) => Systeminfo(
    phone: json["phone"],
  );

  Map<String, dynamic> toJson() => {
    "phone": phone,
  };
}
