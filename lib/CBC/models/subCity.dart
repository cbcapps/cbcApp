// To parse this JSON data, do
//
//     final subCity = subCityFromJson(jsonString);

import 'dart:convert';

List<SubCity> subCityFromJson(String str) => List<SubCity>.from(json.decode(str).map((x) => SubCity.fromJson(x)));

String subCityToJson(List<SubCity> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class SubCity {
  int id;
  String title;
  String city;

  SubCity({
    required this.id,
    required this.title,
    required this.city,
  });

  factory SubCity.fromJson(Map<String, dynamic> json) => SubCity(
    id: json["id"],
    title: json["title"],
    city: json["city"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "city": city,
  };
}
