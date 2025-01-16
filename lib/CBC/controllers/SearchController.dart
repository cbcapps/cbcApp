import 'package:get/get.dart';

import '../Services/RemoteServices.dart';
import '../models/Store.dart';

class SubCitySearchController extends GetxController {
  var isLoadingSearch = true.obs;
  var id = '';
  var city = '';
  dynamic argumentData = Get.arguments;

  // تغيير نوع المتغير إلى List<Story> بدلاً من List<Store>
  var itemsSearch = <Story>[].obs;

  void fetchSearch() async {
    isLoadingSearch(true);
    try {
      // جلب البيانات الخاصة بالـ Store
      var storeData = await RemoteServices.fetchStoriesBySubCity(id);

      if (storeData != null) {
        // تعيين قائمة القصص في itemsSearch
        itemsSearch.value = storeData.stories;  // storeData.stories هو List<Story>
      }
    } finally {
      isLoadingSearch(false);
    }
    update();
  }

  @override
  void onInit() {
    id = argumentData[0]['subCity'];
    city = argumentData[0]['city'];
    fetchSearch();
    super.onInit();
  }
}
