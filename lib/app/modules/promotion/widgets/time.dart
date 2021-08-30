import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class Time extends StatelessWidget {
  const Time({
    Key key,
    this.title,
    this.time,
  }) : super(key: key);

  final String title;
  final DateTime time;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: kBodyTextStyle.copyWith(
              fontSize: kBodyTextSize,
              color: kTextBlackColor,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: kPadding / 2,
        ),
        Text(
          time.toString().split(' ').first ?? '',
          style: kBodyTextStyle.copyWith(
              fontSize: kBodyTextSize,
              color: kHintColor,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
