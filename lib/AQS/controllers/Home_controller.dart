import 'package:get/get.dart';
import 'package:ui_ecommerce/AQS/Services/RemoteServices.dart';
import 'package:ui_ecommerce/AQS/models/Category.dart';
import '../../CBC/models/TestItem.dart';
import '../models/Product.dart';
import '../models/Slider.dart';
import 'package:flutter/material.dart';
class Home_controller extends GetxController {
  int index = 0;
  var isLoadingProductes= true.obs;
  var isLoadingSliders= true.obs;
   List<String> productNames = [];
  var isLoadingCategories= true.obs;
  var productsList = <Product>[].obs;
  var slidersList = <SliderBar>[].obs;
  var filterProducts = <Product>[].obs;
  var categoriesList = <CategoryModel>[].obs;
  late TextEditingController myController = TextEditingController();
  final fixedItem = CategoryModel(
    id: -1,
    title: 'الاقسام',
    image: 'https://i.ibb.co/Z1cjFwp/image.png',
    active: 1,
  );
  //fetch Productes
  Future<List<TestItem>> fetchData() async {
    await Future.delayed(Duration(milliseconds: 2000));
    List<TestItem> _list = [];
    String _inputText = myController.text;
    List<dynamic> filters = await RemoteServices.filterProducts(_inputText);
    for (var jsonItem in filters) {
      _list.add(TestItem.fromJson(jsonItem));
    }
    return _list;
  }
  void fetchProducts() async{
    isLoadingProductes(true);
    try {
      var products = await RemoteServices.fetchProductsRecently();
      if(products != null){
        productsList.value = products;
        isLoadingProductes(false);
      }else{
        isLoadingProductes(false);
      }
    }finally{
      isLoadingProductes(false);

    }
    isLoadingProductes(false);
    update();
  }
  //fetch Sliders
  void fetchSliders() async{
    print("loaddd slider");
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
  }
  //fetch Categories
  void fetchCategories() async{
    isLoadingCategories(true);
    try {
      var categories = await RemoteServices.fetchCategories();
      if(categories != null){
        categoriesList.value = categories;
        if (categoriesList.length >= 7) {
          categoriesList.insert(7, fixedItem);
        } else {
          categoriesList.add(fixedItem);
        }

        isLoadingCategories(true);
        print(isLoadingSliders);
      }
    }finally{
      isLoadingCategories(false);
    }
  }
  void searchProducts(title) async{
    try {
      var filters = await RemoteServices.filterProducts(title);
      if(filters != null){
        filterProducts.value = filters;
        productNames = filterProducts.map((product) => product.title).toList();
        print(productNames);
        update();
      }
    }finally{

    }
    update();
  }
  @override
  void onInit() {
    // TODO: implement onInit
    fetchProducts();
    fetchCategories();
    fetchSliders();
    super.onInit();
  }
  void changeindex(int i){
    index = i;
    update();
  }




}