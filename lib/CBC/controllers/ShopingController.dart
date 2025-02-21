import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/CBC/Services/RemoteServices.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../res/key_sherd_prefs.dart';
import '../models/ShoppingModel.dart';
import '../widgets/shoping_page/dialog_widget_notice_user_favorite.dart';

abstract class AbstractShopingcontroller extends GetxController {
  setListToEmpty();
  Future<void> callMethodFromOtherController({int? curentPage});
  Future<void> listnerScrollControllerMethod();
  Future<void> calledSearchShopingMethod(String inputTxt);
  Future<void> changeShopingIsFavorite(int id);
  Future<void> changeShopingIsFavoriteSearchList(int id);
  // Future<void> removeItemFromListShopingFavorite(int id);

  // Backend Methods
  Future<void> fetchAllShoppingStore({int? curentPage});
  Future<void> addshopingToFavoriteMethod(String storeId);
  Future<void> deleteshopingToFavoriteMethod(String storeId);
  // end Abstract Class
}

class Shopingcontroller extends AbstractShopingcontroller {
  @override
  void onInit() async {
    super.onInit();
    scrollController = ScrollController();

    cbcNumbrControler = TextEditingController();
    // myController = TextEditingController();
    sharedPreferences = await SharedPreferences.getInstance();

    final userIdSherd = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

    if (userIdSherd != null) {
      _userId = userIdSherd.toString();
    }

    // final listFavoriteSherd = getListOfInts();

    // if (listFavoriteSherd != null) {
    //   _listFavorite = listFavoriteSherd;
    // }

    listnerScrollControllerMethod();

    await fetchAllShoppingStore();
    // fetchAllShoppingStoreFavoriteUser();

    // end Method
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();

    cbcNumbrControler.dispose();
    // myController.dispose();
    // end Method
  }

  late ScrollController scrollController;

  late TextEditingController cbcNumbrControler;
  // late TextEditingController myController;

  ShoppingModel _slectedShoping = ShoppingModel(
      discountCount: '',
      facebook: '',
      id: 1000000000,
      instagram: '',
      logo: '',
      isFavorite: 0,
      totalNumberItems: 0,
      name: 'No Name');

  late SharedPreferences sharedPreferences;
  RxBool _checkAddCBCnumbr = true.obs;
  bool _isLoadingSearch = false;
  bool _isLoading = true;
  bool _isFetching = false; // Add this flag at the top of your class

  RxBool _loadingPagination = false.obs;

  RxBool _loadingPaginationSearch = false.obs;
  int _currentPage = 1;

  RxInt _chosenFilter = 0.obs;
  String _typeFilter = 'id';
  String _descAscArange = 'desc';
  String _userId = '11ert';

  List<FilterShoppingModel> _listFilters = [
    FilterShoppingModel(txt: '209'.tr, type: 'id', descAsc: 'desc'),
    FilterShoppingModel(txt: '210'.tr, type: 'id', descAsc: 'asc'),
    FilterShoppingModel(txt: '211'.tr, type: 'discount', descAsc: 'desc'),
    FilterShoppingModel(txt: '212'.tr, type: 'discount', descAsc: 'asc'),
  ];

  List<ShoppingModel> _listShopingStore = <ShoppingModel>[].obs;
  List<ShoppingModel> _listShopingSearch = [];

  RxList<String> _listImagesSliders = <String>[
    // Shopping
    'https://raw.githubusercontent.com/aliapp9728/uploaded_images_project/refs/heads/main/images/shoping_image.jpg',
  ].obs;

  // We Should Try   RxList<int> with Favorite Items

  // List<int> _listFavorite = [];

  // Getter
  // ---------------
  List<ShoppingModel> get listShopingSearch => _listShopingSearch;
  ShoppingModel get slectedShoping => _slectedShoping;
  List<FilterShoppingModel> get listFilters => _listFilters;
  RxList<String> get listImagesSliders => _listImagesSliders;
  List<ShoppingModel> get listShopingStore => _listShopingStore;
  // List<int> get listFavorite => _listFavorite;
  RxBool get checkAddCBCnumbr => _checkAddCBCnumbr;
  RxBool get loadingPagination => _loadingPagination;
  bool get isLoadingSearch => _isLoadingSearch;
  RxBool get loadingPaginationSearch => _loadingPaginationSearch;

  RxInt get chosenFilter => _chosenFilter;
  bool get isLoading => _isLoading;

  Future<void> onRefreshMethod() async {
    _currentPage = 1;
    _typeFilter = 'id';
    _descAscArange = 'desc';
    _listShopingStore = [];
    _chosenFilter.value = 0;
    await fetchAllShoppingStore();
    // end Method
  }

  filterStoreMethod(String filterType, String arrangeType, int newIndex) async {
    _listShopingStore = [];
    _currentPage = 1;
    _descAscArange = arrangeType;
    _typeFilter = filterType;
    // update();
    _chosenFilter.value = newIndex;
    await fetchAllShoppingStore();
    // end Method
  }

  Future<void> openurl(_url) async {
    launchUrlString(_url);
  }

  // bool checkItemIfFavorite(int id) {
  //   if (_listFavorite.contains(id)) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }

  // addItemToFavorite(int id) {
  //   final checkNumbr = sharedPreferences.getString(KeySherdPrefs.numbrCardCBC);

  //   if (checkNumbr != null) {
  //     if (_listFavorite.contains(id)) {
  //       _listFavorite.remove(id);
  //     } else {
  //       _listFavorite.add(id);
  //     }
  //     update();

  //     // checkItemIfFavorite(id);

  //     storeListOfInts(_listFavorite);
  //   } else {
  //     Get.defaultDialog(
  //       title: '',
  //       titlePadding: EdgeInsets.zero,
  //       contentPadding: EdgeInsets.zero,
  //       backgroundColor: Colors.white,
  //       content: DialogWidgetNoticeUserFavoriteCustom(),
  //     );
  //   }

  //   // end Method
  // }

  saveNumbrCBCMethod() async {
    final check = cbcNumbrControler.text.trim();

    if (check.isNotEmpty) {
      _checkAddCBCnumbr(true);
      _userId = check;
      await sharedPreferences.setString(KeySherdPrefs.numbrCardCBC, check);
      Get.back();
    } else {
      _checkAddCBCnumbr(false);
    }
    // end Method
  }

  // removeItemFromFavorite(int id) {
  //   _listFavorite.remove(id);
  //   update();
  //   storeListOfInts(_listFavorite);
  //   // end Method
  // }

  // Future<void> storeListOfInts(List<int> integers) async {
  //   // final prefs = await SharedPreferences.getInstance();
  //   String jsonString = jsonEncode(integers); // Convert to JSON string
  //   await sharedPreferences.setString('myIntList', jsonString);
  // }

  // List<int>? getListOfInts() {
  //   // final prefs = await SharedPreferences.getInstance();
  //   String? jsonString = sharedPreferences.getString('myIntList');

  //   if (jsonString != null) {
  //     List<dynamic> jsonList = jsonDecode(jsonString); // Decode JSON
  //     return jsonList.cast<int>(); // Convert dynamic list to List<int>
  //   }
  //   return null; // Return null if not found
  // }

  @override
  Future<void> fetchAllShoppingStore({int? curentPage}) async {
    print('\n');
    print('The Method Has Called To Fetch All Shoping');
    print('\n');
    if (_listShopingStore.isEmpty) {
      // _isLoading(true);
      _isLoading = true;
      update();
    }

    if (curentPage != null) {
      _currentPage = curentPage;
    }
    try {
      // String
      // final userIdShared = sharedPreferences.getString(KeySherdPrefs.numbrCardCBC);
      List<ShoppingModel>? offersList = await RemoteServices.fetchShoppingModel(
        _currentPage.toString(),
        _typeFilter,
        _descAscArange,
        '',
        '25',
        _userId,
        // '',
        '',
      );
      if (offersList != null) {
        _listShopingStore.addAll(offersList);
        if (_listShopingStore.isNotEmpty) {
          _currentPage++;
        }

        _listShopingSearch.addAll(_listShopingStore);
        update();

        _loadingPagination.value = false;
      } else {}
    } finally {
      _isLoading = false;
      update();
    }
    update();
  }

  @override
  Future<void> addshopingToFavoriteMethod(String storeId) async {
    try {
      final reslt =
          await RemoteServices.addShopingToFavoriteData(_userId, storeId);

      if (reslt == 'success') {
        //
        return;
      } else {
        // do Something
        // like Toast Message or Wrong Number CBC Card And Ask For Another
      }
    } finally {}
    // end Method
  }

  @override
  Future<void> deleteshopingToFavoriteMethod(String storeId) async {
    try {
      final reslt =
          await RemoteServices.deleteShopingToFavoriteData(_userId, storeId);

      if (reslt == 'success') {
        //
        return;
      } else {
        // do Something
        // like Toast Message or Wrong Number CBC Card And Ask For Another
      }
    } finally {}
    // end Method
  }

//
  // Future<void> getTheSelctedShop(int id) async {
  //   if (_listShopingSearch != null) {
  //     for (final ShoppingModel item in _listShopingSearch!) {
  //       if (item.id == id) {
  //         _slectedShoping = item;
  //         Get.to(() => ItemshopingScreen());
  //         return;
  //       }
  //     }
  //   }
  //   // end Method
  // }

  @override
  Future<void> calledSearchShopingMethod(String inputTxt) async {
    _listShopingSearch = [];
    _isLoadingSearch = true;

    update();
    await Future.delayed(
      Duration(milliseconds: 1500),
      () async {
        await fetchStoresBySearch(inputTxt, isSearch: true);
      },
    );

    // end Method
  }

  Future<void> fetchStoresBySearch(String inputTxt,
      {bool isSearch = false}) async {
    // await Future.delayed(Duration(milliseconds: 2000));

    if (_listShopingSearch.isEmpty) {
      _isLoadingSearch = true;
      update();
    }
    try {
      final listResult = await RemoteServices.fetchShoppingModel(
        '1',
        _typeFilter,
        _descAscArange,
        inputTxt.trim(),
        '35',
        _userId,
        '',
      );

      if (listResult != null) {
        if (isSearch) {
          _listShopingSearch = [];
        }
        _listShopingSearch.addAll(listResult);

        // for (final ShoppingModel jsonItem in _listShopingSearch!) {
        //   // _list.add(TestItem.fromJson(jsonItem));
        //   // _list.add(TestItem(label: jsonItem.name, value: jsonItem.id));
        // }
      }

      _loadingPaginationSearch(false);
    } finally {
      // _isLoadingSearch(false);
      _isLoadingSearch = false;
      update();
    }
    // end Method
  }

  // Old One
  // -----------------------
  // Future<List<TestItem>> fetchStoresBySearch() async {
  //   await Future.delayed(Duration(milliseconds: 2000));
  //   List<TestItem> _list = [];
  //   String _inputText = myController.text.trim();
  //   // List<dynamic> filters = await RemoteServices.fetchShoppingModel(_currentPage.toString(), _typeFilter, _descAscArange,);
  //   _listShopingSearch = await RemoteServices.fetchShoppingModel(
  //       '1', _typeFilter, _descAscArange, _inputText, '35');

  //   if (_listShopingSearch != null) {
  //     for (final ShoppingModel jsonItem in _listShopingSearch!) {
  //       // _list.add(TestItem.fromJson(jsonItem));
  //       _list.add(TestItem(label: jsonItem.name, value: jsonItem.id));
  //     }
  //   }
  //   return _list;
  // }

  // @override
  // Future<void> listnerScrollControllerMethod() async {
  //   scrollController.addListener(() async {
  //     double threshold = scrollController.position.maxScrollExtent * 0.8;
  //     if (scrollController.position.pixels >= threshold) {
  //       _loadingPagination.value = true;

  //       await fetchAllShoppingStore();
  //       _loadingPagination.value = false;
  //     }
  //   });
  //   // end Method
  // }
  @override
  Future<void> listnerScrollControllerMethod() async {
    scrollController.addListener(() async {
      if (_isFetching) return; // Prevent multiple calls

      // Check if all items are already loaded

      if (_listShopingStore.isNotEmpty) {
        final totalItems = _listShopingStore[0].totalNumberItems ?? 0;
        if (_listShopingStore.length >= totalItems) return;
      }

      final threshold = scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels >= threshold) {
        _isFetching = true; // Set flag to block concurrent requests
        _loadingPagination.value = true;

        try {
          await fetchAllShoppingStore();
        } finally {
          _isFetching = false; // Reset flag even if error occurs
          _loadingPagination.value = false;
        }
      }
    });
  }

  @override
  Future<void> changeShopingIsFavorite(int id) async {
    final checkCardNumbr = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

    if (checkCardNumbr != null) {
      for (final ShoppingModel shop in _listShopingStore) {
        if (shop.id == id) {
          shop.isFavorite = shop.isFavorite == 0 ? 1 : 0;

          // _listShopingUserFavorite.value = [];
          // _currentFavoritePage = 1;

          // _isLoadingFavoritePage = true;
          _listShopingSearch = [];

          _listShopingSearch.addAll(_listShopingStore);
          update();
          // Call Method Backend ADD Or Delete From Favorite
          if (shop.isFavorite == 1) {
            // Add To Favorite
            await addshopingToFavoriteMethod(shop.id.toString());
          } else {
            await deleteshopingToFavoriteMethod(shop.id.toString());
            // Delete From Favorite
          }
          // fetchAllShoppingStoreFavoriteUser();
          break;
        }

        //  end For
      }
    } else {
      Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: DialogWidgetNoticeUserFavoriteCustom(),
      );
    }

    // We Do Backedn Here
    // end Method
  }

  // @override
  // Future<void> removeItemFromListShopingFavorite(int id) async {
  //   for (final ShoppingModel shop in _listShopingUserFavorite) {
  //     if (shop.id == id) {
  //       // _listShopingUserFavorite.remove(shop);
  //       // update();
  //       await deleteshopingToFavoriteMethod(shop.id.toString());

  //       _listShopingSearch = [];
  //       _listShopingStore = [];
  //       _currentFavoritePage = 1;
  //       _currentPage = 1;
  //       _listShopingUserFavorite.value = [];
  //       fetchAllShoppingStoreFavoriteUser();

  //       fetchAllShoppingStore();
  //       break;
  //     }
  //     // end For
  //   }
  //   // end Method
  // }

  @override
  Future<void> changeShopingIsFavoriteSearchList(int id) async {
    final checkCardNumbr = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

    if (checkCardNumbr != null) {
      for (final ShoppingModel shop in _listShopingSearch) {
        if (shop.id == id) {
          shop.isFavorite = shop.isFavorite == 0 ? 1 : 0;
          _listShopingStore = [];
          // _listShopingUserFavorite.value = [];
          // _currentFavoritePage = 1;
          _currentPage = 1;
          _isLoading = true;
          // _isLoadingFavoritePage = true;
          update();
          // Call Method Backend ADD Or Delete From Favorite
          if (shop.isFavorite == 1) {
            // Add To Favorite
            await addshopingToFavoriteMethod(shop.id.toString());
          } else {
            await deleteshopingToFavoriteMethod(shop.id.toString());
            // Delete From Favorite
          }
          // _listShopingStore = [];
          // _listShopingUserFavorite.value = [];
          // _currentFavoritePage = 1;
          // _currentPage = 1;
          // update();
          fetchAllShoppingStore();
          // fetchAllShoppingStoreFavoriteUser();
          break;
        }

        //  end For
      }
    } else {
      Get.defaultDialog(
        title: '',
        titlePadding: EdgeInsets.zero,
        contentPadding: EdgeInsets.zero,
        backgroundColor: Colors.white,
        content: DialogWidgetNoticeUserFavoriteCustom(),
      );
    }

    // end Method
  }

  @override
  setListToEmpty() {
    _listShopingSearch = [];
    _listShopingStore = [];
    update();
    //end Method
  }

  @override
  Future<void> callMethodFromOtherController({int? curentPage}) async {
    setListToEmpty();
    sharedPreferences.reload();
    final cardNumbr = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC) ?? 0;

    _userId = cardNumbr.toString();
    await fetchAllShoppingStore(curentPage: curentPage);
    // End Method
  }

  // end Class Controller of Shopping
}

class FilterShoppingModel {
  final String txt;
  final String type;
  final String descAsc;

  FilterShoppingModel({
    required this.txt,
    required this.type,
    required this.descAsc,
  });
}
