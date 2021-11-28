import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/profile/components/profile_body_component.dart';
import 'package:served_food/app/modules/profile/components/profile_header_component.dart';
import 'package:served_food/app/modules/profile/controllers/profile_controller.dart';
import 'package:skeletons/skeletons.dart';

class ProfileView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileController controller = Get.put(ProfileController());

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: kBodyTextStyle.copyWith(
              fontSize: kTitleTextSize,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        backgroundColor: kBtnColorStart,
      ),
      body: Stack(
        children: [
          Container(
            height: 100,
            color: kBtnColorStart,
          ),
          Obx(() {
            return Column(
              children: [
                ProfileHeaderComponent(user: controller.user.value),
                SizedBox(height: kPadding),
                Expanded(
                    child: SingleChildScrollView(
                  child: ProfileBodyComponent(
                    user: controller.user.value,
                  ),
                )),
              ],
            );
          })
        ],
      ),
    );
  }
}
