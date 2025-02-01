List<CategoryMapModel> categoryMapModelFromJsonDecode(dynamic extracted) =>
    List<CategoryMapModel>.from(
        extracted.map((x) => CategoryMapModel.fromJson(x)));

class CategoryMapModel {
  int id;
  String title;
  String image;

  /*
   {
      "id": 2,
      "title": "بغداد الكرخ",
      "image": "https://89.116.110.51:3000/uploads/1717924209886.png",
      "active": 1,
      "city": 1,
      "pin": 0
    },
  */

  CategoryMapModel({
    required this.id,
    required this.title,
    required this.image,
  });
  factory CategoryMapModel.fromJson(Map<String, dynamic> json) =>
      CategoryMapModel(
        id: json["id"],
        title: json["title"],
        image: json["image"],
      );

//  end Class
}
