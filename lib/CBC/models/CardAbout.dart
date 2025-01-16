import 'dart:convert';
CardAbout cardAboutFromJson(String str) => CardAbout.fromJson(json.decode(str));

String cardAboutToJson(CardAbout data) => json.encode(data.toJson());

class CardAbout {
  List<About> about;
  List<Doing> doing;
  List<Doing> features;

  CardAbout({
    required this.about,
    required this.doing,
    required this.features,
  });

  factory CardAbout.fromJson(Map<String, dynamic> json) => CardAbout(
    about: List<About>.from(json["about"].map((x) => About.fromJson(x))),
    doing: List<Doing>.from(json["doing"].map((x) => Doing.fromJson(x))),
    features: List<Doing>.from(json["features"].map((x) => Doing.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "about": List<dynamic>.from(about.map((x) => x.toJson())),
    "doing": List<dynamic>.from(doing.map((x) => x.toJson())),
    "features": List<dynamic>.from(features.map((x) => x.toJson())),
  };
}

class About {
  String imageFront;
  String imageBack;
  int id;

  About({
    required this.imageFront,
    required this.imageBack,
    required this.id,
  });

  factory About.fromJson(Map<String, dynamic> json) => About(
    imageFront: json["image_front"],
    imageBack: json["image_back"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "image_front": imageFront,
    "image_back": imageBack,
    "id": id,
  };
}

class Doing {
  int id;
  String title;

  Doing({
    required this.id,
    required this.title,
  });

  factory Doing.fromJson(Map<String, dynamic> json) => Doing(
    id: json["id"],
    title: json["title"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
  };
}


class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
