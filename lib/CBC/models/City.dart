import 'dart:convert';
List<City> cityFromJson(String str) => List<City>.from(json.decode(str).map((x) => City.fromJson(x)));
String cityToJson(List<City> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class City {
  int id;
  String title;
  String image;
  int active;

  City({
    required this.id,
    required this.title,
    required this.image,
    required this.active,
  });

  factory City.fromJson(Map<String, dynamic> json) => City(
    id: json["id"],
    title: json["title"],
    image: json["image"],
    active: json["active"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "image": image,
    "active": active,
  };
}
