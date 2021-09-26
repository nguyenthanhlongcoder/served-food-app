import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/routes/app_routes.dart';

class CheckoutResultView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/svg_pictures/checked.svg',
              width: Get.width / 2,
            ),
            SizedBox(
              height: kPadding * 2,
            ),
            GestureDetector(
              onTap: () {
                Get.back();
                Get.back();
                Get.back();
                Get.back();
              },
              child: Container(
                width: Get.width,
                height: 48,
                decoration: BoxDecoration(
                  color: Color(0xFF32BA7C),
                  boxShadow: kBtnShadow,
                  borderRadius: BorderRadius.circular(kBtnRadius),
                ),
                alignment: Alignment.center,
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
