import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/app_widgets/product_item.dart';
import 'package:served_food/app/modules/home/components/home_message_list.dart';
import 'package:served_food/app/modules/home/components/promotion_slider.dart';
import 'package:served_food/app/modules/home/components/home_appbar.dart';
import 'package:served_food/app/routes/app_pages.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        flexibleSpace: HomeAppBar(),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: kPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: kPadding * 2,
            ),
            Text(
              'Thông báo',
              style: kBodyTextStyle.copyWith(
                  fontSize: kSubtitleTextSize,
                  color: kTextBlackColor,
                  fontWeight: FontWeight.w500),
            ),
            SizedBox(
              height: kPadding * 1.5,
            ),
            // HomeMessageList(),
            SizedBox(
              height: kPadding * 1.5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Promotion',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kSubtitleTextSize,
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  'View all',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kBtnColorStart,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
            SizedBox(
              height: kPadding * 1.5,
            ),
            // PromotionSlider(),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(vertical: kPadding * 1.5),
              child: Row(
                children: [
                  ProductItem(),
                  SizedBox(
                    width: kPadding * 1,
                  ),
                  ProductItem(),
                  SizedBox(
                    width: kPadding * 1,
                  ),
                  ProductItem()
                ],
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  Get.toNamed(AppPages.LOGIN);
                  new UserRepository().deleteAll();
                },
                child: Text('logout'))
          ],
        ),
      ),
    );
  }
}
