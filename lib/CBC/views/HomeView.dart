import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:ui_ecommerce/CBC/views/EvaluationView.dart';
import 'package:ui_ecommerce/CBC/views/FatoraView.dart';
import 'package:ui_ecommerce/CBC/views/SearchView.dart';
import 'package:ui_ecommerce/CBC/widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
import 'package:ui_ecommerce/res/colors.dart';
import 'package:ui_ecommerce/res/images_path.dart';
import 'package:ui_ecommerce/res/pages_name.dart';
import '../../res/method_utls.dart';
import '../controllers/Home_controller.dart';
import '../models/TestItem.dart';

import '../widgets/joint_widgets/notification_widget_cus.dart';
import '../widgets/joint_widgets/pop_menue_home_offer_page_cus.dart';
import '../widgets/lacation/open_street_cus.dart';
import '../widgets/loading_widget/progress_circular_cus.dart';
import '../widgets/joint_widgets/search_text_input_cus.dart';
import 'StorePage.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final Chome_controller controller =
      Get.put(Chome_controller(), permanent: true);
  @override
  Widget build(BuildContext context) {
    print('\n');
    print('----------------------------====================================');
    print('\n');
    print('The  Page 17 ');
    print('\n');
    print('----------------------------====================================');
    print('\n');
    return
        // Stack(
        //   children: [
        Scaffold(
      appBar: appBarShopingOfersPageCustom(
          AppImages.logoCbcEmpty,
          '0'.tr,
          Get.height * 0.05,
          Get.width * 0.15,
          PopMenueHomeOfferPageCustom(),
          builIconNotifcation(),
          null,
          true),
      body: RefreshIndicator(
        child: content(context),
        onRefresh: () async {
          controller.fetchCountMessages();
          controller.fetchRecently();
          controller.fetchHighest();
          controller.fetchCities();
          controller.fetchSliders();
        },
      ),
    );
  }

  Container content(context) {
    return Container(
      color: Colors.white,
      // margin: EdgeInsets.only(bottom: 20),
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
                left: Get.width * 0.05,
                right: Get.width * 0.05,
                top: Get.height * 0.015),
            child: Row(
              children: [
                searchTextInput(), // إدخال النص للبحث
                SizedBox(width: Get.width * 0.02),
                InkWell(
                  onTap: () {
                    _showGovernorateDialog(
                        context); // عرض الحوار لاختيار المحافظة
                  },
                  child: Container(
                    // color: Colors.amber,
                    // padding: EdgeInsetsDirectional.only(
                    //   start: Get.width * 0.03,
                    //   top: Get.width * 0.02,
                    // ),
                    width: Get.width * 0.1,
                    height: Get.height * 0.05,
                    child: SvgPicture.asset(
                      AppImages.filterSquareBlue,
                      fit: BoxFit.fill,
                    ),
                    // child: Icon(
                    //   Icons.filter_alt_rounded,
                    //   size: Get.width * 0.1,
                    // ),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: Get.height * 0.02,
          ),
          // التعامل مع الـ Sliders
          Obx(() {
            if (!controller.isLoadingSliders.value) {
              return (controller.slidersList.isNotEmpty)
                  ? sliders()
                  : placholder404();
            } else {
              return placholderSlider();
            }
          }),
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                GetBuilder<Chome_controller>(builder: (builder) {
                  if (!builder.isLoadingCities.value) {
                    if (builder.citiesList.isNotEmpty) {
                      return citys();
                    } else {
                      return Center(
                        child: Text('${'20'.tr}'), // لا توجد محافظات
                      );
                    }
                  } else {
                    return Center(
                      child: SpinKitWave(
                        color: AppColors.cbcColor,
                        size: Get.width * 0.1,
                      ),
                    );
                  }
                }),
                Container(
                  // color: Colors.amber,
                  height: Get.width * 0.2,
                  child: Center(
                    child: ListView(
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center items horizontally
                          children: [
                            InkWell(
                              onTap: () {
                                print('\n');
                                print('UnFocus Method');
                                print('\n');
                                FocusScope.of(context).unfocus();
                                Get.to(() => FatoraView());
                              },
                              child: SizedBox(
                                height: Get.width * 0.1,
                                width: Get.width * 0.5,
                                child: Image.asset(
                                  'assets/images/icons/upload.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Get.to(() => EvaluationView());
                              },
                              child: SizedBox(
                                width: Get.width * 0.5,
                                height: Get.width * 0.1,
                                child: Image.asset(
                                  'assets/images/icons/share.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                DiscountLabel('89'.tr, 'recentlyStories'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<Chome_controller>(builder: (builder) {
                  if (!builder.isLoadingRecently.value) {
                    if (builder.highestList.isNotEmpty) {
                      return recentlDiscountItems(builder.recentlyList);
                    } else {
                      return Center(
                        child: Text('${'20'.tr}'),
                      );
                    }
                  } else {
                    return Center(
                      child: SpinKitWave(
                        color: AppColors.cbcColor,
                        size: Get.width * 0.1,
                      ),
                    );
                  }
                }),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                DiscountLabel('221'.tr, 'HighestStories'),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<Chome_controller>(
                  builder: (builder) {
                    if (!builder.isLoadingHighest.value) {
                      if (builder.highestList.isNotEmpty) {
                        return discountItems(builder.highestList, false);
                      } else {
                        return Center(
                          child: Text('${'20'.tr}'),
                        );
                      }
                    } else {
                      return Center(
                        child: SpinKitWave(
                          color: AppColors.cbcColor,
                          size: Get.width * 0.1,
                        ),
                      );
                    }
                  },
                ),
                DiscountLabel('222'.tr, PagesName.hieghestDiscountDinarScrn),
                SizedBox(
                  height: Get.height * 0.02,
                ),
                GetBuilder<Chome_controller>(
                  builder: (builder) {
                    if (!builder.isLoadingHighestDinnar.value) {
                      if (builder.highestListDinnar.isNotEmpty) {
                        return discountItems(builder.highestListDinnar, true);
                      } else {
                        return Center(
                          child: Text('${'20'.tr}'),
                        );
                      }
                    } else {
                      return Center(
                        child: SpinKitWave(
                          color: AppColors.cbcColor,
                          size: Get.width * 0.1,
                        ),
                      );
                    }
                  },
                ),

                // Map
                Container(
                  height: Get.height * 0.3,
                  width: Get.width * 0.9,
                  padding: EdgeInsets.symmetric(horizontal: Get.width * 0.04),
                  child: Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(Get.width * 0.05),
                        child: FlutterMapPuplicJointCustom(
                          // initialCenterCus: LatLng(33.3045585, 44.3421706),
                          initialCenterCus: controller.initCenter.value,
                          markers: controller.markersStore,
                          isActive: false,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Get.toNamed(PagesName.mapStoreScren);
                        },
                        child: Container(
                            // color: Colors.amber,
                            ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.06,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  placholder404() {
    return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white60)),
      margin: EdgeInsets.all(Get.height * 0.004),
      child: Center(
          child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: Image.asset(
          'assets/images/comingsoon.jpg',
          fit: BoxFit.fill,
        ),
      )),
    );
  }

  placholderSlider() {
    return Container(
      height: Get.height * 0.3,
      width: Get.width * 0.97,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Colors.white60)),
      margin: EdgeInsets.all(Get.height * 0.004),
      child: ProgressCircularWidgetCustom(),
    );
  }

  discountItems(list, bool isDinnar) {
    return SizedBox(
      height: Get.height * 0.15,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: (list.length > 6) ? 6 : list.length,
        itemBuilder: (context, index) {
          var Item = list[index];
          return DiscountItem(
              Item.image, Item.store, Item.storeId, Item.discount,
              isDinnar: isDinnar);
        },
      ),
    );
  }

  recentlDiscountItems(list) {
    return SizedBox(
      height: Get.height * 0.15,
      child: ListView.builder(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemCount: (list.length > 6) ? 6 : list.length,
        itemBuilder: (context, index) {
          var Item = list[index];
          return DiscountItem(
              Item.image, Item.store, Item.storeId, Item.discount,
              isDiscountString: true);
        },
      ),
    );
  }

  DiscountItem(String url, String label, int id, discount,
      {bool isDinnar = false, bool isDiscountString = false}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => StorePage(), arguments: [
          {"id": id}
        ]);
        //Get.toNamed('/products' , arguments: [{'id':id}]);
      },
      child: Padding(
        padding: EdgeInsetsDirectional.only(
            start: Get.height * 0.01, end: Get.height * 0.01),
        child: Column(
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(15))),
              height: Get.height * 0.08,
              width: Get.height * 0.08,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(45.0),
                child: CachedNetworkImage(
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ProgressCircularWidgetCustom(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(
              height: Get.height * 0.003,
            ),
            SizedBox(
              width: Get.width * 0.24,
              child: Text(label,
                  maxLines: 1,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: Get.height * 0.011)),
            ),
            SizedBox(
              height: Get.height * 0.003,
            ),
            Row(
              children: [
                const Text(
                  'الخصم ',
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  // '${discount.toString()}',
                  isDiscountString
                      ? '${discount.toString()}'
                      : MethodsClassUTls.formatNumber(number: discount) +
                          (isDinnar ? '220'.tr : '%'),
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      color: AppColors.cbcRed,
                      fontWeight: FontWeight.bold,
                      fontSize: Get.height * 0.018),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  DiscountLabel(title, page) {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          start: Get.height * 0.02, end: Get.height * 0.02),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Container(
                width: Get.height * 0.005,
                height: Get.height * 0.02,
                color: AppColors.cbcRed,
              ),
              SizedBox(
                width: Get.height * 0.01,
              ),
              Text(
                title,
                style: TextStyle(
                    fontSize: Get.height * 0.02, fontWeight: FontWeight.bold),
              )
            ],
          ),
          GestureDetector(
            onTap: () {
              Get.toNamed('${page}');
            },
            child: Row(
              children: [
                Text(
                  "90".tr,
                  style: TextStyle(
                      fontSize: Get.height * 0.016,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  width: Get.height * 0.007,
                ),
                const Icon(
                  Icons.arrow_circle_left_outlined,
                  color: AppColors.cbcRed,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget searchTextInput() {
    TextEditingController controllerr = controller.myController;
    return SizedBox(
      width: Get.width * 0.78,
      height: Get.height * 0.05,
      child: GetBuilder<Chome_controller>(
        builder: (c) {
          return SearchTextInputCustom(
            hintTxt: '88'.tr,
            controllerCus: controllerr,
            futureFunction: () {
              return controller.fetchData();
            },
            getSelectedValueCus: (value) {
              if (value != null) {
                TestItem selectedItem =
                    value as TestItem; // تأكد من أن القيمة هي من نوع TestItem
                Get.to(() => StorePage(), arguments: [
                  {"id": selectedItem.value}
                ]);
                controller.myController.clear();
              }
            },
          );
        },
      ),
    );
  }

  sliders() {
    return Padding(
      padding: EdgeInsetsDirectional.only(
          top: Get.height * 0.002, end: Get.height * 0.001),
      child: SizedBox(
        height: Get.height * 0.22,
        child: Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                autoPlay: true,
                viewportFraction: 1,
                height: Get.height * 0.18,
                onPageChanged: (index, reason) {
                  controller.changeindex(index);
                },
              ),
              items: controller.slidersList
                  .map((item) => Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.white60)),
                      margin: EdgeInsets.all(Get.height * 0.002),
                      padding: EdgeInsetsDirectional.only(
                          start: Get.height * 0.004,
                          end: Get.height * 0.004,
                          top: Get.height * 0.004,
                          bottom: Get.height * 0.004),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: CachedNetworkImage(
                          imageUrl: item.image,
                          imageBuilder: (context, imageProvider) => Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: imageProvider,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          placeholder: (context, url) =>
                              ProgressCircularWidgetCustom(),
                          errorWidget: (context, url, error) =>
                              const Icon(Icons.error),
                        ),
                      )))
                  .toList(),
            ),
            GetBuilder<Chome_controller>(builder: (c) {
              return DotsIndicator(
                dotsCount: controller.slidersList.length,
                position: c.index,
                decorator: DotsDecorator(
                  color: Colors.grey,
                  size: const Size.square(9.0),
                  activeSize: Size(
                    Get.height * 0.008,
                    Get.height * 0.009,
                  ),
                  activeShape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }

  citys() {
    return GridView.builder(
      padding:
          EdgeInsets.only(left: Get.height * 0.04, right: Get.height * 0.04),
      physics:
          const NeverScrollableScrollPhysics(), // to disable GridView's scrolling
      shrinkWrap: true, // You won't see infinite size error
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20.0,
        mainAxisSpacing: 5.0,
        childAspectRatio: 1.1,
      ),
      itemCount:
          (controller.citiesList.length > 8) ? 8 : controller.citiesList.length,
      itemBuilder: (BuildContext context, int index) {
        final city = controller.citiesList[index];
        return CityItem(
          city.image,
          city.title,
          city.id,
        );
      },
    );
  }

  CityItem(String url, String title, int id) {
    if (id != -1) {
      return GestureDetector(
        onTap: () {
          Get.toNamed('categories_cbc', arguments: [
            {'id': id, 'city': title}
          ]);
        },
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.01),
          width: Get.height * 0.25,
          decoration: BoxDecoration(
              color: AppColors.cbcColor,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Center(
                child: CachedNetworkImage(
                  height: Get.height * 0.05,
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ProgressCircularWidgetCustom(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Get.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    } else {
      return GestureDetector(
        onTap: () {
          controller.onItemTapped(3);
        },
        child: Container(
          padding: EdgeInsets.all(Get.height * 0.01),
          width: Get.height * 0.25,
          decoration: BoxDecoration(
              color: AppColors.cbcRed,
              border: Border.all(color: Colors.black12),
              borderRadius: const BorderRadius.all(Radius.circular(15))),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Center(
                child: CachedNetworkImage(
                  height: Get.height * 0.045,
                  width: Get.height * 0.055,
                  imageUrl: url,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => ProgressCircularWidgetCustom(),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
              SizedBox(
                height: Get.height * 0.005,
              ),
              Center(
                child: Text(
                  title,
                  textAlign: TextAlign.center,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                      fontSize: Get.width * 0.025,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
              )
            ],
          ),
        ),
      );
    }
  }

  void _showGovernorateDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Obx(() {
          return AlertDialog(
            title: Text('اختيار المحافظة'),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // عرض المحافظات في مربعات (3 محافظات في السطر)
                Wrap(
                  spacing: 4.0, // المسافة بين المربعات
                  runSpacing: 8.0, // المسافة بين الأسطر
                  children: [
                    for (final city in controller.citiesList)
                      if (city.id != -1) // استثناء fixedItem
                        GestureDetector(
                          onTap: () {
                            // عند اختيار المحافظة، تحديث قيمة selectedGovernorate وعرض المناطق
                            controller.selectedGovernorate.value = city.title;
                            controller.fetchSubCity(city.title); // جلب المناطق
                          },
                          child: Container(
                            padding: EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              color: controller.selectedGovernorate.value ==
                                      city.title
                                  ? Colors
                                      .blueAccent // تغيير اللون عند الاختيار
                                  : Colors.grey[200],
                              borderRadius: BorderRadius.circular(8),
                              boxShadow: const [
                                BoxShadow(
                                  color: Colors.black26,
                                  blurRadius: 4,
                                  offset: Offset(2, 2),
                                ),
                              ],
                            ),
                            width:
                                (Get.width - 32) / 4, // عرض المربع (4 في السطر)
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  city.title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12),
                                ),
                              ],
                            ),
                          ),
                        ),
                  ],
                ),

                // عرض المناطق بناءً على اختيار المحافظة
                if (controller.selectedGovernorate.isNotEmpty)
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                            'المناطق في ${controller.selectedGovernorate.value}:'),
                        // منطقة ثابتة للمناطق قابلة للتمرير
                        Container(
                          height: 200, // تحديد الارتفاع الثابت
                          child: SingleChildScrollView(
                            child: Wrap(
                              spacing: 4.0,
                              runSpacing: 8.0,
                              children: [
                                for (final area in controller.selectedAreas)
                                  GestureDetector(
                                    onTap: () {
                                      // عند اختيار المنطقة، تحديث selectedArea
                                      controller.selectedArea.value =
                                          area; // تحديد المنطقة
                                    },
                                    child: Container(
                                      width: (Get.width - 32) /
                                          4, // نفس عرض المربعات
                                      padding: EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: controller.selectedArea.value ==
                                                area
                                            ? Colors
                                                .green // تغيير اللون عند الاختيار
                                            : Colors.grey[200],
                                        borderRadius: BorderRadius.circular(8),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Colors.black26,
                                            blurRadius: 4,
                                            offset: Offset(2, 2),
                                          ),
                                        ],
                                      ),
                                      child: Center(
                                        child: Text(
                                          area,
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                        ),
                        // إظهار نص "تمرير لعرض المزيد" إذا كان هناك العديد من المناطق
                        if (controller.selectedAreas.length >
                            12) // يمكن تخصيص العدد الذي يظهر فيه النص
                          Padding(
                            padding: const EdgeInsets.only(top: 8),
                            child: Text(
                              'مرر للاسفل للمزيد...',
                              textAlign: TextAlign.center,
                              style:
                                  TextStyle(fontSize: 12, color: Colors.blue),
                            ),
                          ),
                      ],
                    ),
                  ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('إغلاق'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.selectedArea.value.isNotEmpty) {
                    print('تم تحديد المنطقة: ${controller.selectedArea.value}');
                    Get.to(
                      () => Searchview(),
                      arguments: [
                        {
                          'subCity': controller.selectedArea.value,
                          'city': controller.selectedGovernorate.value,
                        } // إرسال id المنطقة
                      ],
                    );
                  } else {
                    print('لم يتم تحديد المنطقة');
                    // يمكنك أيضًا عرض رسالة للمستخدم أو تأكيد تحديد المنطقة
                    Get.snackbar(
                      "تنبيه",
                      "يرجى اختيار منطقة أولاً",
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }
                },
                child: Text(
                  'بحث',
                  style: TextStyle(
                    color: Colors.white, // تغيير لون النص إلى أبيض
                    fontWeight: FontWeight.bold, // جعل النص عريضًا
                    fontSize: 16, // تكبير حجم الخط
                  ),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.cbcColor, // تعيين لون الخلفية
                  padding: EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 24), // إضافة بعض الحشو داخل الزر
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), // تحديد حواف دائرية
                  ),
                  elevation: 4, // إضافة تأثير الظل
                ),
              ),
            ],
          );
        });
      },
    );
  }

  // Widget widgetDropDown() {
  //   return DropdownButtonHideUnderline(
  //     child: DropdownButton2<CategoriesPageModel>(
  //       iconStyleData: IconStyleData(
  //           icon: Icon(
  //         Icons.menu,
  //         color: Colors.white,
  //         size: 30,
  //       )),

  //       // hint: Center(
  //       //   child: Text(
  //       //     '76'.tr,
  //       //     style: TextStyle(
  //       //       fontSize: Get.width * 0.03,
  //       //       // color: Theme.of(context).hintColor,
  //       //     ),
  //       //   ),
  //       // ),
  //       // isExpanded: true,
  //       items: controller.listPage
  //           .map(
  //             (item) => DropdownMenuItem<CategoriesPageModel>(
  //               child: Column(
  //                 children: [
  //                   Row(
  //                     children: [
  //                       SizedBox(
  //                         height: 24,
  //                         width: 24,
  //                         child: SvgPicture.asset(item.icon),
  //                       ),
  //                       SizedBox(width: 5),
  //                       Text(
  //                         item.txtPage,
  //                         style: TextStyle(
  //                             fontSize: Get.width * 0.03,
  //                             fontWeight: FontWeight.bold),
  //                       ),
  //                       SizedBox(height: 10),
  //                       Divider(
  //                         color: Colors.black,
  //                         height: 0,
  //                       )
  //                     ],
  //                   )
  //                 ],
  //               ),
  //             ),
  //           )
  //           .toList(),
  //       // value: controller.listPage[0],
  //       onChanged: (value) {},
  //       // buttonStyleData: ButtonStyleData(
  //       //   padding: EdgeInsets.symmetric(horizontal: 16),
  //       //   height: Get.width * 0.3,
  //       //   width: Get.width * 0.2,
  //       // ),
  //       // menuItemStyleData: MenuItemStyleData(
  //       //   height: Get.width * 0.08,
  //       // ),
  //     ),
  //   );
  // }

  Widget? builIconNotifcation() {
    return Obx(
      () => NotificationWidgetCustom(
        showCartBadge: controller.showCartBadge.value,
        backgroundMessagesLength: controller.backgroundMessagesLength.value,
        // showCartBadge: true,
        // backgroundMessagesLength: 1,
      ),
      //
    );
  }

  // end Class
}
