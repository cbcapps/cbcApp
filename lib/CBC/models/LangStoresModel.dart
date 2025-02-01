List<LangStoresModel> LangStoresModelFromJsonDecode(dynamic extracted) =>
    List<LangStoresModel>.from(
        extracted.map((x) => LangStoresModel.fromJson(x)));

class LangStoresModel {
  int id;
  String nameStore;
  String locationLink;
  String image;
  double lat;
  double lng;

  LangStoresModel({
    required this.id,
    required this.nameStore,
    required this.locationLink,
    required this.image,
    required this.lat,
    required this.lng,
  });
  factory LangStoresModel.fromJson(Map<String, dynamic> json) =>
      LangStoresModel(
        id: json["id"],
        nameStore: json["name"] ?? 'No Name',
        lat: json["lat"],
        lng: json["lng"],
        locationLink: json["location"],
        image: json["logo"] ??
            'https://tacm.com/wp-content/uploads/2018/01/no-image-available.jpeg',
      );

//  end Class
}
