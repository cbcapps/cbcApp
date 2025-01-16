import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/CardAbout.dart';
import 'package:ui_ecommerce/CBC/models/CardSales.dart';
import 'package:ui_ecommerce/CBC/models/CardType.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Services/RemoteServices.dart';
class CardController extends GetxController with SingleGetTickerProviderMixin{
  TabController? tabController;
  var isLoadingAbout= true.obs;
  var isLoadingSale= true.obs;
  var isLoadingType= true.obs;
  TextEditingController namePerson = TextEditingController();
  TextEditingController phonePerson = TextEditingController();
  TextEditingController addressPerson = TextEditingController();
  CardAbout? cardAbout;
  CardSale? cardSale;
  CardType? cardType;
  String jsonData = '''
    {
  "type": [
    {"id": 1, "type": "بطاقة فئة اشتراك سنة واحدة", "price": 45000},
    {"id": 2, "type": "بطاقة فئة اشتراك 2 سنة", "price": 60000},
    {"id": 3, "type": "بطاقة فئة اشتراك سنة واحدة", "price": 90000},
    {"id": 4, "type": "بطاقة فئة اشتراك 2 سنة", "price": 120000}
  ]
}
  ''';
  var isAddedCart = false.obs;
  var isLoadingAdded = false.obs;
  var subCityList = <String>[].obs;
  var isLoadingSubCity = false.obs;
  var selectedCity = ''.obs;

  var cityList = <String>[].obs;
  var isLoadingCity = false.obs;
  var selectedFullCity = ''.obs;
  var selectedType1 = 0.obs;
  var compsList = <String>[].obs;
  var isLoadingComps = false.obs;
  var selectedComp = ''.obs;
  var isPay = false.obs;

  Future<bool> addOrder() async {
    print('load');
    isLoadingAdded(true);
    // Check if all fields are non-empty
    if (namePerson.text.isNotEmpty &&
        phonePerson.text.isNotEmpty &&
        selectedCity.value.isNotEmpty &&
        selectedFullCity.value.isNotEmpty &&
        addressPerson.text.isNotEmpty &&
        selectedComp.value.isNotEmpty &&
        selectedType1.value != null) {

      var result = await RemoteServices.addOrderBuy(
          namePerson.text.trim(),
          phonePerson.text.trim(),
          selectedFullCity.value,
          selectedCity.value,
          addressPerson.text.trim(),
          selectedComp.value,
          selectedType1.value
      );

      if (result.contains('successfully')) {
        isPay(true);
        print('okk');
        isLoadingAdded(false);
        update();
        return true;
      } else {
        isLoadingAdded(false);
        update();
        return false;
      }
    } else {
      isLoadingAdded(false);
      print('error fields');
      update();
      return false;
    }

  }




  void fetchRecently() async {
    isLoadingSubCity(true);
    try {
      var list = await RemoteServices.fetchSubCity(selectedFullCity.value);
      if (list != null) {
        List<String> titles = list.map<String>((item) => item.title).toList();
        subCityList.value = titles;
      } else {
        isLoadingSubCity(false);
      }
    } catch (e) {
      print('Error fetching sub cities: $e');
    } finally {
      isLoadingSubCity(false);
    }
    update();
  }
  void fetchComps() async {
    isLoadingComps(true);
    try {
      var list = await RemoteServices.fetchComps();
        List<String> titles = list!.map<String>((item) => item.title).toList();
        titles.insert(0, 'بدون مؤسسة');
        compsList.value = titles;
    } catch (e) {
      print('Error fetching sub cities: $e');
    } finally {
      isLoadingComps(false);
    }
    update();
  }

  void fetchCity() async {
    isLoadingComps(true);
    try {
      var list = await RemoteServices.fetchCities();
      List<String> titles = list!.map<String>((item) => item.title).toList();
      cityList.value = titles;

    } catch (e) {
      print('Error fetching sub cities: $e');
    } finally {
      isLoadingComps(false);
    }
    update();
  }

void changeSelect(value){
    selectedFullCity.value = value;
    fetchRecently();
    update();
  }
  void changeLocation(value){
    selectedComp.value = value;
   update();
  }
  void updateType1(value){
    selectedType1.value = value;;
    update();
  }
  void fetchCardAbout() async{
    isLoadingAbout(true);
    try {
      var list = await RemoteServices.fetchCardAbout();
        cardAbout = list;

    }finally{
      isLoadingAbout(false);
    }
    isLoadingAbout(false);
    update();
  }
  //fetch Card types
  void fetchCardType() async{
    isLoadingType(true);
    try {
      CardType cardTypeList = cardTypeFromJson(jsonData);
        cardType = cardTypeList;
    }catch(error){
      print(error.toString());
    }finally{
      isLoadingType(false);
    }
    update();
  }
  void fetchCardSale() async{
    isLoadingSale(true);
    try {
      var list = await RemoteServices.fetchCardSales();
        cardSale = list;
    }finally{
      isLoadingSale(false);
    }
    isLoadingSale(false);
    update();
  }
  void callPhone(phone){
    launchUrlString("tel://${phone}");
  }
  @override
  void onInit() {
    tabController = TabController(length: 2, vsync: this);
    fetchComps();
    fetchCity();
    fetchCardAbout();
    fetchCardType();
    fetchCardSale();

    selectedComp.value = "بدون مؤسسة";

    // TODO: implement onInit
    super.onInit();
  }
}