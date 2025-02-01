// Can Be Deleted

// import 'dart:io';

// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:get/get.dart';

// import '../../../res/colors.dart';
// import '../../models/CategoriesPageModel.dart';

// class MenuDropDownCustom extends StatelessWidget {
//   const MenuDropDownCustom({
//     super.key,
//     required this.showDropDown,
//     required this.lisPage,
//     required this.goToPage,
//   });

//   final bool showDropDown;
//   final List<CategoriesPageModel> lisPage;
//   final Function(String pageName) goToPage;
//   @override
//   Widget build(BuildContext context) {
//     return Positioned.directional(
//       textDirection: Get.locale == Locale('ar', 'IQ')
//           ? TextDirection.rtl
//           : TextDirection.ltr,
//       top: Platform.isAndroid ? Get.height * 0.08 : Get.height * 0.12,
//       end: Get.width * 0.03,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 150),
//         height: showDropDown ? Get.height * 0.2 : 0,
//         width: Get.width * 0.3,
//         decoration: BoxDecoration(
//             color: AppColors.bakgroundDrop,
//             borderRadius: BorderRadius.circular(10)),
//         child: ListView.builder(
//           shrinkWrap: true,
//           physics: const BouncingScrollPhysics(),
//           padding: EdgeInsets.zero,
//           itemCount: lisPage.length,
//           itemBuilder: (context, index) {
//             final item = lisPage[index];
//             return Container(
//               margin: EdgeInsets.only(top: 10, left: 10, right: 10),
//               child: InkWell(
//                 onTap: () {
//                   goToPage(item.pageName);
//                 },
//                 child: Column(
//                   children: [
//                     Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         Container(
//                           margin: EdgeInsets.only(bottom: 5),
//                           child: SizedBox(
//                             height: 20,
//                             width: 20,
//                             child: SvgPicture.asset(item.icon),
//                           ),
//                         ),
//                         SizedBox(width: 5),
//                         Text(
//                           item.txtPage,
//                           style: TextStyle(
//                               fontSize: Get.width * 0.04,
//                               color: AppColors.txtDrop,
//                               fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                     SizedBox(height: 3),
//                     Divider(
//                       color: AppColors.dividerDrop,
//                       // color: Colors.red,
//                       height: 0,
//                     )
//                   ],
//                 ),
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
