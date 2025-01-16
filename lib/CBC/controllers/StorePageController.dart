import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/StoreModel.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../Services/RemoteServices.dart';

class StorePageController extends GetxController with SingleGetTickerProviderMixin{
  StoreModel? store ;
  var isLoadingItem= true.obs;
  int indexSlider = 0;
   TabController? tabController;
   int id = 0;
  dynamic argumentData = Get.arguments;
  void fetchStore() async {
    isLoadingItem(true);

    try {
      var fetchedStore = await RemoteServices.fetchStore(id);
      if (fetchedStore != null) {
        if(fetchedStore.storeinfo.name.isNotEmpty){
          store = fetchedStore;
          isLoadingItem(false);
          print('loaaaaad');
        }

      } else {
        isLoadingItem(false);
      }
    }catch(e){
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
  void callPhone(phone){
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
