// To parse this JSON data, do
//
//     final comp = compFromJson(jsonString);

import 'dart:convert';

List<Comp> compFromJson(String str) => List<Comp>.from(json.decode(str).map((x) => Comp.fromJson(x)));

String compToJson(List<Comp> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Comp {
  int id;
  String title;

  Comp({
    required this.id,
    required this.title,
  });

  factory Comp.fromJson(Map<String, dynamic> json) => Comp(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}
