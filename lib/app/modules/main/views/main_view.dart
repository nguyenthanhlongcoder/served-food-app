import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/modules/chat/views/home_chat_view.dart';
import 'package:served_food/app/modules/home/views/home_view.dart';
import 'package:served_food/app/modules/main/controllers/main_controller.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/modules/profile/views/profile_view.dart';
import 'package:served_food/app/modules/table/views/table_view.dart';

class MainView extends GetView<MainController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox.expand(
          child: PageView(
            physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
            children: [HomeView(), TableView(), HomeChatView(), ProfileView()],
            controller: controller.pageController,
          ),
        ),
        bottomNavigationBar: Obx(() => FancyBottomNavigation(
              circleColor: kBtnColorStart,
              tabs: [
                TabData(
                  iconData: Icons.storefront,
                  title: 'Home',
                ),
                TabData(
                  iconData: Icons.favorite,
                  title: 'Order',
                ),
                TabData(
                  iconData: Icons.message,
                  title: 'Chat',
                ),
                TabData(
                  iconData: Icons.account_circle,
                  title: 'Profile',
                )
              ],
              onTabChangedListener: (position) {
                controller.currentIndex.value = position;
                controller.pageController.jumpToPage(position);
              },
              initialSelection: controller.currentIndex.value,
              key: controller.bottomNavigationKey,
              inactiveIconColor: Colors.grey,
            )));
  }
}
