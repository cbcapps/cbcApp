import 'package:flutter/cupertino.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/City.dart';
import 'package:ui_ecommerce/CBC/models/Discount.dart';
import 'package:ui_ecommerce/main.dart';
import '../Services/RemoteServices.dart';
import '../models/Slider.dart';
import '../models/Store.dart';
import '../models/TestItem.dart';

class Chome_controller extends GetxController {
  final fixedItem = City(
    id: -1,
    title: 'المحافظات',
    image: 'https://static.vecteezy.com/system/resources/previews/019/633/209/original/doodle-freehand-drawing-of-iraq-map-free-png.png',
    active: 1,
  );
  late TextEditingController myController = TextEditingController();
  int selectedIndex = 0;
  int index = 0;
  var showCartBadge = false.obs;
  RxInt backgroundMessagesLength = 0.obs;
  var isLoadingRecently= true.obs;
  var isLoadingSearch= true.obs;
  var isLoadingHighest= true.obs;
  var isLoadingSliders= true.obs;
  List<String> productNames = [];
  var isLoadingCities= true.obs;
  var recentlyList = <Discount>[].obs;
  var itemsSearch = <Store>[].obs;
  var highestList = <Discount>[].obs;
  var slidersList = <SliderBar>[].obs;
  var citiesList = <City>[].obs;
  var selectedGovernorate = ''.obs;  // المحافظة المختارة
  var selectedArea = ''.obs;
  var selectedAreas = <String>[].obs; // المناطق المختارة


  void fetchSubCity(String governorateName) async {
    selectedArea.value = '';
    try {
      var areas = await RemoteServices.fetchSubCity(governorateName);
      if (areas != null) {
        selectedAreas.value = areas.map((e) => e.title).toList(); // تحويل المناطق إلى قائمة نصوص
      } else {
        selectedAreas.clear();
      }
    } catch (e) {
      selectedAreas.clear();
      print("Error fetching sub cities: $e");
    }
  }


  Future<List<TestItem>> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    List<TestItem> _list = [];
    String _inputText = myController.text;
    List<dynamic> filters = await RemoteServices.filterStories(_inputText);
    for (var jsonItem in filters) {
      _list.add(TestItem.fromJson(jsonItem));
    }
    return _list;
  }
  fetchCountMessages(){
    sharedPreferences.reload();
     int count = sharedPreferences.getInt('unread_notifications_count') ?? 0;
    print('shard is : ${sharedPreferences.getInt('unread_notifications_count')}');
    backgroundMessagesLength.value = count;
    print('count notif : ${count}');
    if(count! > 0 ){
      showCartBadge(true);
    }else{
      showCartBadge(false);
    }
    print('notificaions is : ${count}');
    update();
  }
  _printLatestValue() {
    print("Textfield value: ${myController.text}");

    //print("Textfield value: ${myController.text}");
  }
  void onItemTapped(int index) {
    selectedIndex = index;
    print('tap: ${index}');
    update();
  }
  //fetch RecentlyDiscount
  void fetchRecently() async{
    isLoadingRecently(true);
    try {
      var recentlylist = await RemoteServices.fetchDiscountRecently();
      if(recentlylist != null){
        recentlyList.value = recentlylist;
      }else{
      }
    }finally{
      isLoadingRecently(false);
    }
    update();
  }

  void fetchSearch(subCity) async{
    isLoadingSearch(true);
    try {
      var recentlylist = await RemoteServices.fetchStoriesBySubCity(subCity);
      if(recentlylist != null){
        itemsSearch.value = [recentlylist];
      }else{
      }
    }finally{
      isLoadingSearch(false);
    }
    update();
  }
  //fetch HighestDiscount
  void fetchHighest() async{
    isLoadingHighest(true);
    try {
      var highestlylist = await RemoteServices.fetchDiscountHighest();
      if(highestlylist != null){
        highestList.value = highestlylist;
      }else{
      }
    }finally{
      isLoadingHighest(false);
    }
    update();
  }
  //fetch Sliders
  void fetchSliders() async{
    isLoadingSliders(true);
    try {
      var sliders = await RemoteServices.fetchSliders();

      if(sliders != null){
        isLoadingSliders(true);
        slidersList.value = sliders;
      }
    }finally{
      isLoadingSliders(false);
    }
    update();
  }
  //fetch Categories
  void fetchCities() async {
    isLoadingCities(true);
    try {
      var cities = await RemoteServices.fetchCities();
      if (cities != null) {
        citiesList.value = cities;
        if (citiesList.length >= 5) {
          citiesList.insert(5, fixedItem);
          isLoadingCities(false);
        } else {
          citiesList.add(fixedItem);
          isLoadingCities(false);
        }
      }
    } finally {

    }
    update();
  }


  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('okk');
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    print("okkkk");
  }
  @override
  void onReady() {
    // TODO: implement onReady
    super.onReady();
    print("ok");
  }
  @override
  void onInit() {
    // TODO: implement onInit

    FlutterAppBadger.updateBadgeCount(1);
    sharedPreferences.reload();
    fetchCountMessages();
    fetchRecently();
    fetchHighest();
    fetchCities();
    fetchSliders();

    super.onInit();
  }
  void changeindex(int i){
    index = i;
    update();
  }

}