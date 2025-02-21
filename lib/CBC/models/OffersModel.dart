List<OffersModel> offerModelFromJson(dynamic extracted, int totalItems) =>
    List<OffersModel>.from(
        extracted.map((x) => OffersModel.fromJson(x, totalItems)));

class OffersModel {
  int id;
  int totalNumberItems;
  String name;
  String logo;

  String link;

  String discount;

  OffersModel({
    required this.id,
    required this.totalNumberItems,
    required this.name,
    required this.logo,
    required this.link,
    required this.discount,
  });

  /*
 {
      "id": 29,
      "name": "عيادة كهرمانة للاشعة التداخلية والسونار والدوبلر الملون",
      "imgPath": "https://89.116.110.51:3000/uploads/1718142123675.jpg",
      "description": " عيادة تخصصية لجميع فحوصات الاشعة التداخلية(القسطرة)/ الاشعة العادية / الاشعة الملونة / السونار و الدوبلر الملون ",
      "pin": 0,
      "link": "",
      "discount": "40"
    },
*/

  factory OffersModel.fromJson(Map<String, dynamic> json, int totalItems) =>
      OffersModel(
        id: json["id"] ?? 0,
        totalNumberItems: totalItems,
        name: json["name"] ?? 'Empty Name',
        logo: json["imgPath"] ?? '',
        link: json["link"] ?? '',
        discount: json["discount"].toString(),
      );

  //  end Method
}
