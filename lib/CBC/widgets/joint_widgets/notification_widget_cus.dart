import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:badges/badges.dart' as badges;

import '../../views/Messages.dart';

class NotificationWidgetCustom extends StatelessWidget {
  const NotificationWidgetCustom({
    super.key,
    required this.showCartBadge,
    required this.backgroundMessagesLength,
  });

  final bool showCartBadge;
  final int backgroundMessagesLength;

  @override
  Widget build(BuildContext context) {
    return Container(
      // color: Colors.amber,
      child: GestureDetector(
        onTap: () {
          Get.to(() => MessagesView());
        },
        child: badges.Badge(
          position: badges.BadgePosition.bottomEnd(bottom: 4, end: 15),
          badgeAnimation: badges.BadgeAnimation.slide(),
          showBadge: showCartBadge,
          badgeStyle: badges.BadgeStyle(
            badgeColor: Colors.redAccent,
          ),
          badgeContent: Text(
            backgroundMessagesLength.toString(),
            style: TextStyle(color: Colors.white),
          ),
          child: Icon(
            Icons.notifications,
            color: Colors.white,
            size: Get.height * 0.035,
          ),
        ),
      ),
    );
  }
}
