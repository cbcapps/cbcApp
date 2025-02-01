// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:ui_ecommerce/CBC/widgets/joint_widgets/appbar_shoping_ofers_page_cus.dart';
// import 'package:ui_ecommerce/res/images_path.dart';

// import '../controllers/ShopingController.dart';
// import '../widgets/shoping_page/item_sliver_list_cus.dart';

// class ItemshopingScreen extends StatelessWidget {
//   ItemshopingScreen({super.key});

//   final Shopingcontroller _shopingController = Get.find();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: appBarShopingOfersPageCustom(
//           AppImages.logoCbcEmpty,
//           '',
//           Get.height * 0.03,
//           Get.width * 0.1,
//           Container(),
//           Container(),
//           true,
//           false),
//       body: Container(
//         color: Colors.white,
//         child: Padding(
//           padding: EdgeInsets.only(
//             // top: Getheight * 0.02,
//             top: Get.width * 0.07,
//             right: Get.width * 0.04,
//             left: Get.width * 0.04,
//           ),
//           child: Column(
//             children: [
//               GetBuilder<Shopingcontroller>(builder: (_) {
//                 return ItemSliverListCustom(
//                   isIndexZero: false,
//                   checkLastItem: false,
//                   isFavorite: ite,
//                   onTapFavorite: () {
//                     _shopingController.addItemToFavorite(
//                         _shopingController.slectedShoping.id);
//                   },
//                   onTapFacbook: () {
//                     _shopingController
//                         .openurl(_shopingController.slectedShoping.facebook);
//                   },
//                   onTapInstgram: () {
//                     _shopingController
//                         .openurl(_shopingController.slectedShoping.instagram);
//                   },
//                   shoppingModel: _shopingController.slectedShoping,
//                 );
//               })
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
