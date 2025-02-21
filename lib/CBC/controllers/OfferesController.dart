import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/Services/RemoteServices.dart';
import 'package:url_launcher/url_launcher_string.dart';

import '../models/Discount.dart';
import '../models/OffersModel.dart';

class OffersController extends GetxController {
  @override
  void onInit() async {
    super.onInit();
    ('\n');
    ('=========================');
    ('The  onInit Offer Controller ');
    ('\n');
    scrollController = ScrollController();

    listnerScrollControllerMethod();

    await fetchAllOffers();
    // end Method
  }

  late ScrollController scrollController;

  bool _isFetching = true;
  RxBool _isLoading = true.obs;
  RxBool _loadingPagination = false.obs;
  int _currentPage = 1;
  RxString _orderBy = 'desc'.obs;
  // من الزبون يطلب اعلى الخصومات تنطي هاي desc
  // ومن يريد اقل الخصومات تنطي هاي asc

  RxList<OffersModel> _listOffers = <OffersModel>[].obs;
  RxList<String> _listImagesSliders = <String>[
    // Offer
    'https://raw.githubusercontent.com/aliapp9728/uploaded_images_project/refs/heads/main/images/offer_image.jpg',
  ].obs;

  // Getter
  // ---------------
  RxBool get isLoading => _isLoading;
  RxBool get loadingPagination => _loadingPagination;
  RxList<String> get listImagesSliders => _listImagesSliders;
  RxList<OffersModel> get listOffers => _listOffers;
  RxString get orderBy => _orderBy;

  changeOrderBy(String newValue) {
    _isLoading(true);
    _orderBy.value = newValue;
    _listOffers.value = [];
    _currentPage = 1;
    // Future.delayed(
    //   Duration(seconds: 5),
    //   () {
    fetchAllOffers();
    //   },
    // );
  }

  refreshMethod() {
    // _isLoading(true);
    _listOffers.value = [];
    _currentPage = 1;
    fetchAllOffers();
  }

  // listnerScrollControllerMethod() {

  //   scrollController.addListener(() async {
  //     if (scrollController.position.pixels ==
  //         scrollController.position.maxScrollExtent) {
  //       _loadingPagination.value = true;

  //       await fetchAllOffers();
  //     }
  //   });
  //   // end Method
  // }

  // listnerScrollControllerMethod() {
  //   scrollController.addListener(() async {
  //     // Set the threshold as a percentage of the max scroll extent (e.g., 80%)
  //     double threshold = scrollController.position.maxScrollExtent * 0.8;

  //     // Trigger the method if the current position exceeds the threshold
  //     if (scrollController.position.pixels >= threshold) {
  //       if (!_loadingPagination.value) {
  //         _loadingPagination.value = true;
  //         await fetchAllOffers();
  //         _loadingPagination.value = false;
  //       }
  //     }
  //   });
  // }

  listnerScrollControllerMethod() {
    scrollController.addListener(() async {
      if (_isFetching) return; // Prevent multiple calls

      // Check if all items are already loaded

      if (_listOffers.isNotEmpty) {
        final totalItems = _listOffers[0].totalNumberItems;
        if (_listOffers.length >= totalItems) return;
      }

      final threshold = scrollController.position.maxScrollExtent;
      if (scrollController.position.pixels >= threshold) {
        _isFetching = true; // Set flag to block concurrent requests
        _loadingPagination.value = true;

        try {
          await fetchAllOffers();
        } finally {
          _isFetching = false; // Reset flag even if error occurs
          _loadingPagination.value = false;
        }
      }
    });
  }

  //fetch HighestDiscount
  Future<void> fetchAllOffers() async {
    if (_listOffers.isEmpty) {
      _isLoading(true);
    }
    try {
      ('\n');
      ('=========================');
      ('The List is Calledd');
      ('\n');

      List<OffersModel>? offersList =
          // await RemoteServices.fethHighestLowestDisccount();
          await RemoteServices.fetchOffersSection(
              _currentPage.toString(), _orderBy.value);
      if (offersList != null) {
        // _listOffers.value = offersList;
        _listOffers.addAll(offersList);
        if (_listOffers.isNotEmpty) {
          _currentPage++;
        }

        _loadingPagination.value = false;
      } else {}
    } finally {
      _isLoading(false);
    }
    update();
  }

  Future<void> openurl(_url) async {
    launchUrlString(_url);
  }

  // end Class Controller
}
