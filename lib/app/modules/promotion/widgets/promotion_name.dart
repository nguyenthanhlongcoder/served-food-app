import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class PromotionName extends StatelessWidget {
  const PromotionName({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title ?? '',
      style: kBodyTextStyle.copyWith(
          fontSize: kTitleTextSize,
          color: kTextBlackColor,
          fontWeight: FontWeight.w500),
    );
  }
}
