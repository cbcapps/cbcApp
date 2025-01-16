import 'dart:convert';
List<CallCenterModel> callCenterModelFromJson(String str) => List<CallCenterModel>.from(json.decode(str).map((x) => CallCenterModel.fromJson(x)));
String callCenterModelToJson(List<CallCenterModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));
class CallCenterModel {
  int id;
  String city;
  String phone;
  CallCenterModel({
    required this.id,
    required this.city,
    required this.phone,
  });
  factory CallCenterModel.fromJson(Map<String, dynamic> json) => CallCenterModel(
    id: json["id"],
    city: json["city"],
    phone: json["phone"],
  );
  Map<String, dynamic> toJson() => {
    "id": id,
    "city": city,
    "phone": phone,
  };
}
