import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/models/Store.dart';

import '../Services/RemoteServices.dart';

class StoreController extends GetxController {
  var isLoadingStories= true.obs;
  var isLoadingFilter= true.obs;
  int id = 0;
  RangeValues currentRangeValues = const RangeValues(0, 100);
  int cate = 0;
  int city = 0;
  int orderby = 0;
  var isFilter= false.obs;
  String? city_name;
  String? cate_name;
  final List<String> items = [
    'الاحدث',
    'الاقدم',
    'الاعلى خصم',
    'الادنى خصم',
  ];
  String? selectedValue;

  dynamic argumentData = Get.arguments;
  var storiesList = <Store>[].obs;
  void fetchStories(orderby) async{
    isLoadingStories(true);
    try {
      var list = await RemoteServices.fetchStories(cate,city , orderby);
      if(list != null){
        storiesList.value = [list];
        print('Data : ${storiesList[0].stories.length}');
      }else{
        print('loading not');
        isLoadingStories(false);
      }
    }finally{
      isLoadingStories(false);
    }
    isLoadingStories(false);
    update();
  }
  void filterItems(orderby) async{
    isFilter(true);
    try {
      var list = await RemoteServices.fetchStories(cate,city , orderby);
      if(list != null){
        storiesList.value = [list];
        print('Data : ${storiesList[0].stories.length}');
      }else{
        print('loading not');
        isFilter(false);
      }
    }finally{
      isFilter(false);
    }
    isFilter(false);
    update();
  }

  void changeFilter(value){
    selectedValue = value;
    filterItems(items.indexOf(value) + 1);

    update();
  }
@override
  void onInit() {
    id = argumentData[0]['id'];
    city = argumentData[0]['city'];
    cate = argumentData[0]['cate'];
    cate_name = argumentData[0]['cate_name'];
    city_name = argumentData[0]['city_name'];
    print('City : ${city} Cate : ${cate}');
    fetchStories(1);
    // TODO: implement onInit
    super.onInit();
  }



}