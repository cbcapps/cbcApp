import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/StoreModel.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Services/RemoteServices.dart';

class StorePageController extends GetxController
    with GetSingleTickerProviderStateMixin {
  StoreModel? store;
  var isLoadingItem = true.obs;
  int indexSlider = 0;
  // double _heightTabPage = Get.height * 0.4;
  TabController? tabController;
  int id = 0;
  dynamic argumentData = Get.arguments;

  // double get heightTabPage => _heightTabPage;

  // changeHeightTapPage(int index, double heightWithAppbar) {
  //   // index == 0  handle discount
  //   if (index == 0) {
  //     // height: heightAppBarCustom(context) * 0.075,
  //     //  it will be ( heightWithAppbar * 0.075 ) * store!.storeinfo.discounts.length
  //     _heightTabPage =
  //         (heightWithAppbar * 0.075) * store!.storeinfo.discounts.length;
  //     update();
  //     return;
  //   }
  //   // index == 1  handle Branches
  //   if (index == 1) {
  //     // (heightAppBarCustom(context) * 0.07) * tore!.storeinfo.branches.length
  //     _heightTabPage =
  //         (heightWithAppbar * 0.07) * store!.storeinfo.branches.length;
  //     update();
  //     return;
  //   }

  //   // index == 2  handle Images && index == 3  handle Offers
  //   if (index == 2 || index == 3) {
  //     // heightAppBarCustom(context) * 0.4,
  //     _heightTabPage = heightWithAppbar * 0.4;
  //     update();
  //     return;
  //   }

  //   // end Method
  // }

  void fetchStore() async {
    isLoadingItem(true);

    try {
      var fetchedStore = await RemoteServices.fetchStore(id);
      if (fetchedStore != null) {
        if (fetchedStore.storeinfo.name.isNotEmpty) {
          store = fetchedStore;
          isLoadingItem(false);
          print('loaaaaad');
        }
      } else {
        isLoadingItem(false);
      }
    } catch (e) {
      print(e.toString());
    } finally {
      print('ok ok');
      isLoadingItem(false);
    }
    isLoadingItem(false);
    update();
  }

  Future<void> openurl(_url) async {
    launchUrlString(_url);
  }

  void callPhone(phone) {
    launchUrlString("tel://${phone}");
  }

  launchWhatsAppUri(phone) async {
    String infoText = '';
    String whatsappUrl =
        "whatsapp://send?phone=$phone" "&text=${Uri.encodeFull(infoText)}";
    try {
      launchUrlString(whatsappUrl);
    } catch (e) {
      //handle error properly
    }
  }

  @override
  void onInit() {
    tabController = TabController(length: 4, vsync: this);
    id = argumentData[0]['id'];
    fetchStore();
    // TODO: implement onInit
    super.onInit();
  }
}
