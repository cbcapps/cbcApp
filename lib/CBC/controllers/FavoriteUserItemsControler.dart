import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ui_ecommerce/CBC/Services/RemoteServices.dart';
import 'package:ui_ecommerce/CBC/controllers/ShopingController.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../../res/key_sherd_prefs.dart';
import '../models/ShoppingModel.dart';

class FavoriteUserItemsControler extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    scrollControllerFavoriteUser = ScrollController();
    listnerScrollControllerFavoritePageMethod();
    sharedPreferences = await SharedPreferences.getInstance();

    final userIdSherd = sharedPreferences.getInt(KeySherdPrefs.numbrCardCBC);

    if (userIdSherd != null) {
      _userId = userIdSherd.toString();
    }

    await fetchAllShoppingStoreFavoriteUser();

    // end Method
  }

  @override
  void dispose() {
    super.dispose();
    scrollControllerFavoriteUser.dispose();
    // end Method
  }

  final Shopingcontroller _shopingcontroller = Get.find();
  bool _isFetching = false; // Add this flag at the top of your class
  late ScrollController scrollControllerFavoriteUser;
  late SharedPreferences sharedPreferences;
  String _userId = '11ert';
  int _currentFavoritePage = 1;
  int _numberItemRemoved = 0;
  bool _isLoadingFavoritePage = true;
  RxBool _loadingPaginationFavoritePage = false.obs;
  RxList<ShoppingModel> _listShopingUserFavorite = <ShoppingModel>[].obs;

  // Getter
  // ---------------
  RxList<ShoppingModel> get listShopingUserFavorite => _listShopingUserFavorite;
  bool get isLoadingFavoritePage => _isLoadingFavoritePage;
  RxBool get loadingPaginationFavoritePage => _loadingPaginationFavoritePage;

  Future<void> fetchAllShoppingStoreFavoriteUser() async {
    if (_listShopingUserFavorite.isEmpty) {
      // _isLoading(true);
      _isLoadingFavoritePage = true;
      update();
    }

    try {
      // String
      // final userIdShared = sharedPreferences.getString(KeySherdPrefs.numbrCardCBC);
      List<ShoppingModel>? shopingList =
          await RemoteServices.fetchShoppingModel(
        _currentFavoritePage.toString(),
        'id',
        'desc',
        '',
        '25',
        _userId,
        'true',
      );
      if (shopingList != null) {
        _listShopingUserFavorite.addAll(shopingList);

        if (_listShopingUserFavorite.isNotEmpty) {
          _currentFavoritePage++;
        }

        update();

        _loadingPaginationFavoritePage.value = false;
      } else {}
    } finally {
      _isLoadingFavoritePage = false;
      update();
    }

    update();

    // end Method
  }

  // Future<void> listnerScrollControllerFavoritePageMethod() async {
  //   print('\n');
  //   print(
  //       'Scroll Controller Favorite And Lenght List Items is ${_listShopingUserFavorite.length} And Number Items is $_numbritems');
  //   print('\n');

  //   scrollControllerFavoriteUser.addListener(() async {
  //     // await sharedPreferences.reload();
  //     // if (_numbritems != null && _listShopingUserFavorite.length == _numbritems)
  //     //   return;

  //     if (_listShopingUserFavorite.isNotEmpty) {
  //       print('\n');
  //       print('=====================The Number========================');
  //       print('\n');
  //       print(
  //           'The total Number Favorite is ${_listShopingUserFavorite[0].totalNumberItems}');
  //       print('\n');
  //       print('The Length List Is ${_listShopingUserFavorite.length}');
  //       print('\n');
  //       print('====================The Number========================');
  //       print('\n');
  //     }

  //     double threshold =
  //         // scrollControllerFavoriteUser.position.maxScrollExtent * 0.8;
  //         scrollControllerFavoriteUser.position.maxScrollExtent;
  //     if (scrollControllerFavoriteUser.position.pixels >= threshold) {
  //       _loadingPaginationFavoritePage.value = true;

  //       await fetchAllShoppingStoreFavoriteUser();

  //       _loadingPaginationFavoritePage.value = false;
  //     }
  //   });
  //   // end Method
  // }

  Future<void> listnerScrollControllerFavoritePageMethod() async {
    scrollControllerFavoriteUser.addListener(() async {
      if (_isFetching) return; // Prevent multiple calls

      // Check if all items are already loaded
      if (_listShopingUserFavorite.isNotEmpty) {
        final totalItems = _listShopingUserFavorite[0].totalNumberItems ?? 0;
        if (_listShopingUserFavorite.length >= totalItems - _numberItemRemoved)
          return;
      }

      final threshold = scrollControllerFavoriteUser.position.maxScrollExtent;
      if (scrollControllerFavoriteUser.position.pixels >= threshold) {
        _isFetching = true; // Set flag to block concurrent requests
        _loadingPaginationFavoritePage.value = true;

        try {
          await fetchAllShoppingStoreFavoriteUser();
        } finally {
          _isFetching = false; // Reset flag even if error occurs
          _loadingPaginationFavoritePage.value = false;
        }
      }
    });
  }

  Future<void> openurl(_url) async {
    launchUrlString(_url);
  }

  Future<void> removeItemFromListShopingFavorite(int id) async {
    for (final ShoppingModel shop in _listShopingUserFavorite) {
      if (shop.id == id) {
        // _listShopingUserFavorite.remove(shop);
        // update();
        int lenghtOne = _listShopingUserFavorite.length;
        _listShopingUserFavorite.removeWhere(
          (element) {
            return element.id == id;
          },
        );
        int lenghtTwo = _listShopingUserFavorite.length;

        final check = lenghtOne > lenghtTwo;
        print('\n');
        print('Removed From ListUserFavorite is $check');
        print('\n');

        if (check) {
          _numberItemRemoved++;
        }

        update();

        _shopingcontroller.setListToEmpty();
        await Future.wait([
          _shopingcontroller.deleteshopingToFavoriteMethod(shop.id.toString()),
          _shopingcontroller.fetchAllShoppingStore(curentPage: 1),
        ]);

        break;
      }
      // end For
    }
    // end Method
  }

  // end Class Controller
}
