import 'dart:convert';
List<QrModel> qrModelFromJson(String str) => List<QrModel>.from(json.decode(str).map((x) => QrModel.fromJson(x)));

String qrModelToJson(List<QrModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QrModel {
  int id;
  String image;

  QrModel({
    required this.id,
    required this.image,
  });

  factory QrModel.fromJson(Map<String, dynamic> json) => QrModel(
    id: json["id"],
    image: json["image"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "image": image,
  };
}
