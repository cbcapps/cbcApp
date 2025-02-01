// Keys
// FlutterAppBadger.updateBadgeCount(1);
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
// import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';
import 'package:ui_ecommerce/CBC/models/City.dart';
import 'package:ui_ecommerce/CBC/models/Discount.dart';
import 'package:ui_ecommerce/main.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Services/RemoteServices.dart';
import '../models/CategoryMapModel.dart';
import '../models/LangStoresModel.dart';
import '../models/RecentlyDiscount.dart';
import '../models/Slider.dart';
import '../models/Store.dart';
import '../models/TestItem.dart';
import '../widgets/lacation/widget_dialog_details_sotre_loaction.dart';
import '../widgets/lacation/widget_loaction_store.dart';

abstract class AbstractHomeController extends GetxController {
  // Methods
  addLangMarkers();
  onRefreshFetchHighestDiscountDinnar();
  listnerScrollControllerHighestDiscontDinnarMethod();
  chosecategoryLang(String newVal, int index);
  // Listner to Controller
  listnerScrollControllerCategoryLange();
  // Backend Method
  Future<void> fetchHighestDinnar();
  Future<void> fetchLangStoresMethod();
  Future<void> fetchCategoryLatLangMethod();
  // end Abstract
}

class Chome_controller extends AbstractHomeController {
  final fixedItem = City(
    id: -1,
    title: 'المحافظات',
    image:
        'https://static.vecteezy.com/system/resources/previews/019/633/209/original/doodle-freehand-drawing-of-iraq-map-free-png.png',
    active: 1,
  );
  late TextEditingController myController = TextEditingController();
  late ScrollController scrollControllerCategoryLang;
  late ScrollController scrollControllerRecentlyDicont;
  late ScrollController scrollControllerHeighestDicont;
  late ScrollController scrollControllerHeighestDicontDinnar;

  RxBool _loadingPaginationRecntlyDiscont = false.obs;
  RxBool _loadingPaginationHeightestDiscont = false.obs;
  RxBool _loadingPaginationHeightestDiscontDinnar = false.obs;
  RxBool _loadingPaginationCategoryLang = false.obs;
  int _curentPageRecentlyDiscount = 1;
  int _curentPageHeighestDiscount = 1;
  int _curentPageHeighestDiscountDinnar = 1;
  int _curentPageCategoryLang = 1;
  int selectedIndex = 1;
  int index = 0;
  int _selctedCategory = 0;
  var showCartBadge = false.obs;
  RxInt backgroundMessagesLength = 0.obs;
  RxBool _isLoadingCategory = true.obs;
  RxBool _isLoadingMap = true.obs;
  var isLoadingRecently = true.obs;
  var isLoadingSearch = true.obs;
  var isLoadingHighest = true.obs;
  RxBool isLoadingHighestDinnar = true.obs;
  var isLoadingSliders = true.obs;
  RxList<Marker> _markersStore = <Marker>[].obs;
  List<String> productNames = [];
  RxList<LangStoresModel> _listLangStore = <LangStoresModel>[].obs;
  var isLoadingCities = true.obs;
  var recentlyList = <RecentlyDiscount>[].obs;
  var itemsSearch = <Store>[].obs;
  var highestList = <Discount>[].obs;
  RxList<Discount> highestListDinnar = <Discount>[].obs;
  var slidersList = <SliderBar>[].obs;
  var citiesList = <City>[].obs;
  var selectedGovernorate = ''.obs; // المحافظة المختارة
  var selectedArea = ''.obs;
  var selectedAreas = <String>[].obs; // المناطق المختارة
  String? _categoryMapLang = '';
  RxList<CategoryMapModel> _listCategoryLang = <CategoryMapModel>[
    CategoryMapModel(id: 200000, title: '218'.tr, image: '')
  ].obs;
  Rx<LatLng> _initCenter = LatLng(33.3045585, 44.3421706).obs;
  double _latitude = 0.0;
  double _longitude = 0.0;

  // Getter
  // ------------
  int get selctedCategory => _selctedCategory;
  RxBool get loadingPaginationRecntlyDiscont =>
      _loadingPaginationRecntlyDiscont;
  RxBool get loadingPaginationCategoryLang => _loadingPaginationCategoryLang;
  RxBool get loadingPaginationHeightestDiscontDinnar =>
      _loadingPaginationHeightestDiscontDinnar;
  RxBool get loadingPaginationHeightestDiscont =>
      _loadingPaginationHeightestDiscont;
  RxBool get isLoadingMap => _isLoadingMap;
  RxBool get isLoadingCategory => _isLoadingCategory;

  RxList<LangStoresModel> get listLangStore => _listLangStore;
  RxList<Marker> get markersStore => _markersStore;
  Rx<LatLng> get initCenter => _initCenter;
  RxList<CategoryMapModel> get listCategoryLang => _listCategoryLang;
  //  RxBool _isLoadingMap

  void fetchSubCity(String governorateName) async {
    selectedArea.value = '';
    try {
      var areas = await RemoteServices.fetchSubCity(governorateName);
      if (areas != null) {
        selectedAreas.value =
            areas.map((e) => e.title).toList(); // تحويل المناطق إلى قائمة نصوص
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

  fetchCountMessages() {
    sharedPreferences.reload();
    int count = sharedPreferences.getInt('unread_notifications_count') ?? 0;
    print(
        'shard is : ${sharedPreferences.getInt('unread_notifications_count')}');
    backgroundMessagesLength.value = count;
    print('count notif : ${count}');
    if (count! > 0) {
      showCartBadge(true);
    } else {
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

  onRefreshFetchRecent() async {
    recentlyList.value = [];
    _curentPageRecentlyDiscount = 1;
    await fetchRecently();
    // end Method
  }

  //fetch RecentlyDiscount
  fetchRecently() async {
    if (recentlyList.isEmpty) {
      isLoadingRecently(true);
    }
    try {
      List<RecentlyDiscount>? recentlylistFetch =
          await RemoteServices.fetchDiscountRecently(
              _curentPageRecentlyDiscount.toString());
      if (recentlylistFetch != null) {
        // recentlyList.value = recentlylistFetch;
        recentlyList.addAll(recentlylistFetch);
        if (recentlyList.isNotEmpty) {
          _curentPageRecentlyDiscount++;
        }
        _loadingPaginationRecntlyDiscont(false);
      } else {}
    } finally {
      isLoadingRecently(false);
    }
    update();
  }

  void fetchSearch(subCity) async {
    isLoadingSearch(true);
    try {
      var recentlylist = await RemoteServices.fetchStoriesBySubCity(subCity);
      if (recentlylist != null) {
        itemsSearch.value = [recentlylist];
      } else {}
    } finally {
      isLoadingSearch(false);
    }
    update();
  }

  onRefreshFetchHighestDiscount() async {
    highestList.value = [];
    _curentPageHeighestDiscount = 1;

    await fetchHighest();
    //end Method
  }

  onRefreshFetchHighestDiscountDinnar() async {
    highestListDinnar.value = [];
    _curentPageHeighestDiscountDinnar = 1;

    await fetchHighestDinnar();
    //end Method
  }

  //fetch HighestDiscount
  fetchHighest() async {
    if (highestList.isEmpty) {
      isLoadingHighest(true);
    }
    try {
      List<Discount>? highestlylistFetch =
          await RemoteServices.fetchDiscountHighest(
              _curentPageHeighestDiscount.toString(), '');
      if (highestlylistFetch != null) {
        // highestList.value = highestlylistFetch;
        highestList.addAll(highestlylistFetch);
        if (highestList.isNotEmpty) {
          _curentPageHeighestDiscount++;
        }
      } else {}
    } finally {
      isLoadingHighest(false);
    }

    update();
  }

  //fetch HighestDiscount
  @override
  Future<void> fetchHighestDinnar() async {
    if (highestListDinnar.isEmpty) {
      isLoadingHighestDinnar(true);
    }
    try {
      List<Discount>? highestlylistFetch =
          await RemoteServices.fetchDiscountHighest(
              _curentPageHeighestDiscountDinnar.toString(), 'true');
      if (highestlylistFetch != null) {
        // highestList.value = highestlylistFetch;
        highestListDinnar.addAll(highestlylistFetch);
        if (highestList.isNotEmpty) {
          _curentPageHeighestDiscountDinnar++;
        }
      } else {}
    } finally {
      isLoadingHighestDinnar(false);
    }

    update();
  }

  //fetch Sliders
  void fetchSliders() async {
    isLoadingSliders(true);
    try {
      var sliders = await RemoteServices.fetchSliders();

      if (sliders != null) {
        isLoadingSliders(true);
        slidersList.value = sliders;
      }
    } finally {
      isLoadingSliders(false);
    }
    update();
  }

  getUserLoaction() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // setState(() {
      //   locationMessage = "Location services are disabled.";
      // });
      return;
    }

    // Check location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // setState(() {
        //   locationMessage = "Location permissions are denied.";
        // });
        return;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // setState(() {
      //   locationMessage =
      //       "Location permissions are permanently denied, we cannot request permissions.";
      // });
      return;
    }
    // Get the current position
    Position position = await Geolocator.getCurrentPosition();

    // locationMessage =
    //     "Latitude: ${position.latitude}, Longitude: ${position.longitude}";
    print('\n');
    print('=================00000450404--------------------');
    print('Latitude: ${position.latitude}, Longitude: ${position.longitude}');
    print('\n');

    /*
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
    */

    // Get.dialog(Container(
    //   margin: EdgeInsets.symmetric(vertical: Get.height * 0.2),
    //   child: Scaffold(
    //     body: Container(
    //       height: Get.height * 0.3,
    //       color: Colors.white,
    //       child: Column(
    //         mainAxisAlignment: MainAxisAlignment.center,
    //         crossAxisAlignment: CrossAxisAlignment.center,
    //         children: [
    //           Text(
    //             'Map Longitude && Latitude',
    //             maxLines: 3,
    //             style: TextStyle(
    //               fontSize: 15,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 20,
    //           ),
    //           Text(
    //             'Latitude: ${position.latitude}',
    //             maxLines: 3,
    //             style: TextStyle(
    //               fontSize: 15,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //           SizedBox(
    //             height: 10,
    //           ),
    //           Text(
    //             'Longitude: ${position.longitude}',
    //             maxLines: 3,
    //             style: TextStyle(
    //               fontSize: 15,
    //               fontWeight: FontWeight.bold,
    //             ),
    //           ),
    //         ],
    //       ),
    //     ),
    //   ),
    // ));

    _initCenter.value = LatLng(position.latitude, position.longitude);
    //  = LatLng(33.2850175, 44.3041719); => Baghdad Ameria

    _latitude = position.latitude;
    _longitude = position.longitude;

    _markersStore
        .add(markerWidget(position.latitude, position.longitude, Colors.green));
    // _markersStore.add(markerWidget(33.2850175, 44.3041719, Colors.green));

    // end Method
  }

  @override
  fetchLangStoresMethod() async {
    _isLoadingMap(true);
    try {
      // List<LangStoresModel>? listLangStore =
      //     await RemoteServices.fetchLatLangStoresData(
      //         '33.3045585', '44.3421706');
      List<LangStoresModel>? listLangStore =
          await RemoteServices.fetchLatLangStoresData(
              _latitude.toString(), _longitude.toString(), _categoryMapLang);
      if (listLangStore != null) {
        // highestList.value = listLangStore;
        _listLangStore.addAll(listLangStore);

        addLangMarkers();
      } else {}
    } finally {
      _isLoadingMap(false);
    }

    // end Method
  }

  @override
  fetchCategoryLatLangMethod() async {
    if (_listCategoryLang.isEmpty) {
      _isLoadingCategory(true);
    }

    try {
      List<CategoryMapModel>? listCategory =
          await RemoteServices.fetchCategoryForLatLongData(
              _curentPageCategoryLang.toString());
      if (listCategory != null) {
        // highestList.value = listCategory;
        _listCategoryLang.addAll(listCategory);
        if (_listCategoryLang.isNotEmpty) {
          _curentPageCategoryLang++;
        }
      } else {}
    } finally {
      _isLoadingCategory(false);
    }

    // end Method
  }

  addLangMarkers() {
    print('\n');
    print('=======================');
    print('\n');
    print('The Lenght of List Lang is ${_listLangStore.length}');
    for (final LangStoresModel item in _listLangStore) {
      _markersStore.add(
        _addMaarkerWidgetBackend(
          imageUrl: item.image,
          latitude: item.lat,
          longitude: item.lng,
          txtStoreCus: item.nameStore,
          langStoreItem: item,
        ),
      );
    }

    // end Method
  }

  markerWidget(double lat, double lng, Color colorMark) {
    return Marker(
      point: LatLng(lat, lng),
      width: 80,
      height: 80,
      child: Icon(
        Icons.location_pin,
        // color: Colors.red,
        color: colorMark,
        size: Get.width * 0.11,
      ),
    );
    // end Method
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
    } finally {}
    update();
  }

  listnerScrollControllerRecentlyDiscontMethod() {
    scrollControllerRecentlyDicont.addListener(() async {
      // Set the threshold as a percentage of the max scroll extent (e.g., 80%)
      double threshold =
          scrollControllerRecentlyDicont.position.maxScrollExtent * 0.8;

      // Trigger the method if the current position exceeds the threshold
      if (scrollControllerRecentlyDicont.position.pixels >= threshold) {
        if (!_loadingPaginationRecntlyDiscont.value) {
          _loadingPaginationRecntlyDiscont.value = true;
          await fetchRecently();
          _loadingPaginationRecntlyDiscont.value = false;
        }
      }
    });
  }

  @override
  listnerScrollControllerCategoryLange() {
    scrollControllerCategoryLang.addListener(() async {
      // Set the threshold as a percentage of the max scroll extent (e.g., 80%)
      double threshold =
          scrollControllerCategoryLang.position.maxScrollExtent * 0.8;

      // Trigger the method if the current position exceeds the threshold
      if (scrollControllerCategoryLang.position.pixels >= threshold) {
        if (!_loadingPaginationCategoryLang.value) {
          _loadingPaginationCategoryLang.value = true;
          await fetchCategoryLatLangMethod();
          _loadingPaginationCategoryLang.value = false;
        }
      }
    });
  }

  listnerScrollControllerHighestDiscontMethod() {
    scrollControllerHeighestDicont.addListener(() async {
      // Set the threshold as a percentage of the max scroll extent (e.g., 80%)
      double threshold =
          scrollControllerHeighestDicont.position.maxScrollExtent * 0.8;

      // Trigger the method if the current position exceeds the threshold
      if (scrollControllerHeighestDicont.position.pixels >= threshold) {
        if (!_loadingPaginationHeightestDiscont.value) {
          _loadingPaginationHeightestDiscont.value = true;
          await fetchHighest();
          _loadingPaginationHeightestDiscont.value = false;
        }
      }
    });
  }

  listnerScrollControllerHighestDiscontDinnarMethod() {
    scrollControllerHeighestDicontDinnar.addListener(() async {
      // Set the threshold as a percentage of the max scroll extent (e.g., 80%)
      double threshold =
          scrollControllerHeighestDicontDinnar.position.maxScrollExtent * 0.8;

      // Trigger the method if the current position exceeds the threshold
      if (scrollControllerHeighestDicontDinnar.position.pixels >= threshold) {
        if (!_loadingPaginationHeightestDiscontDinnar.value) {
          _loadingPaginationHeightestDiscontDinnar.value = true;
          await fetchHighest();
          _loadingPaginationHeightestDiscontDinnar.value = false;
        }
      }
    });
  }

  @override
  void onClose() {
    // TODO: implement onClose
    super.onClose();
    print('okk');
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerHeighestDicontDinnar.dispose();
    scrollControllerHeighestDicont.dispose();
    scrollControllerRecentlyDicont.dispose();
    scrollControllerCategoryLang.dispose();
    print("okkkk");
  }

  @override
  void onReady() {
    super.onReady();
    print("ok");
  }

  @override
  void onInit() async {
    // FlutterAppBadger.updateBadgeCount(1);
    sharedPreferences.reload();
    scrollControllerHeighestDicontDinnar = ScrollController();
    scrollControllerHeighestDicont = ScrollController();
    scrollControllerRecentlyDicont = ScrollController();
    scrollControllerCategoryLang = ScrollController();

    listnerScrollControllerRecentlyDiscontMethod();
    listnerScrollControllerHighestDiscontMethod();
    await getUserLoaction();
    fetchCountMessages();
    fetchCities();
    fetchSliders();
    await fetchHighest();
    fetchHighestDinnar();
    fetchRecently();
    fetchCategoryLatLangMethod();
    fetchLangStoresMethod();

    super.onInit();
  }

  void changeindex(int i) {
    index = i;
    update();
  }

  Future<void> openurl(_url) async {
    launchUrlString(_url);
  }

  @override
  chosecategoryLang(String newVal, int index) {
    _markersStore.value = [];
    // _markersStore.add(markerWidget(33.3045585, 44.3421706, Colors.green));
    _markersStore.add(markerWidget(_latitude, _longitude, Colors.green));
    _listLangStore.value = [];
    _categoryMapLang = newVal;
    _selctedCategory = index;
    update();
    print('\n');
    print('==================');
    print(
        'The Index is $index  and List Lang Lenght is ${_markersStore.length}');
    fetchLangStoresMethod();
    // end Method
  }

  Marker _addMaarkerWidgetBackend(
      {required String imageUrl,
      required String txtStoreCus,
      required double latitude,
      required double longitude,
      required LangStoresModel langStoreItem}) {
    return Marker(
      width: Get.width * 0.25,
      height: Get.height * 0.1,
      point: LatLng(latitude, longitude),
      child: GestureDetector(
        onTap: () {
          Get.defaultDialog(
              title: '',
              titlePadding: EdgeInsets.zero,
              contentPadding: EdgeInsets.zero,
              content: WidgetDialogDetailsSotreLoactionCustom(
                txtNameStore: langStoreItem.nameStore,
                urlImage: langStoreItem.image,
                onTapCus: () {
                  openurl(langStoreItem.locationLink);
                },
              ));
        },
        child: WidgetLoactionStore(
          imageUrl: imageUrl,
          txtStore: txtStoreCus,
        ),
      ),
    );
  }
}
