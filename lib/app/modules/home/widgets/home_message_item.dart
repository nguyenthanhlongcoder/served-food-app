import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class HomeMessageItem extends StatelessWidget {
  const HomeMessageItem({
    Key key,
    this.message,
    this.textColor,
    this.borderColor,
  }) : super(key: key);
  final String message;
  final Color textColor;
  final Color borderColor;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width,
      padding: EdgeInsets.symmetric(
          vertical: kPadding / 3, horizontal: kPadding / 2),
      decoration: BoxDecoration(
          border: Border.all(
            color: borderColor ?? kBtnColorStart,
            width: 2,
          ),
          borderRadius: BorderRadius.all(Radius.circular(kInputBorderRadius))),
      child: Text(
        message ?? '',
        style: kBodyTextStyle.copyWith(
            fontSize: kSubtitleTextSize,
            color: textColor ?? kBtnColorStart,
            fontWeight: FontWeight.w500),
      ),
    );
  }
}
