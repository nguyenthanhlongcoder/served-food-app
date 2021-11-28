import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/providers/log_out.dart';
import 'package:served_food/app/modules/home/components/home_message_list.dart';
import 'package:served_food/app/modules/home/components/promotion_slider.dart';

class HomeView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Home',
          style: kBodyTextStyle.copyWith(
              fontSize: kTitleTextSize,
              color: kBtnColorStart,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.more_horiz,
                color: Colors.black,
              ))
        ],
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              color: Colors.white,
              padding: EdgeInsets.all(kPadding),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Notifications',
                    style: kBodyTextStyle.copyWith(
                        fontSize: kSubtitleTextSize,
                        color: kTextBlackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: kPadding * 1.5,
                  ),
                  HomeMessageList(),
                ],
              ),
            ),
            SizedBox(
              height: kPadding / 2,
            ),
            Container(
              padding: EdgeInsets.all(kPadding),
              color: Colors.white,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Promotions',
                    style: kBodyTextStyle.copyWith(
                        fontSize: kSubtitleTextSize,
                        color: kTextBlackColor,
                        fontWeight: FontWeight.w500),
                  ),
                  SizedBox(
                    height: kPadding * 1.5,
                  ),
                  PromotionSlider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
