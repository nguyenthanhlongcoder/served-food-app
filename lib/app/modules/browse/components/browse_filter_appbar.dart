import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class BrowseFilterAppBar extends StatelessWidget {
  const BrowseFilterAppBar({
    Key key,
    this.title,
  }) : super(key: key);
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: kPadding),
      decoration: BoxDecoration(gradient: kBtnLinearGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Spacer(),
          Row(
            children: [
              BackButton(
                color: Colors.white,
              ),
              Text(
                'Back',
                style: kBodyTextStyle.copyWith(
                    fontSize: kSubtitleTextSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: kPadding),
            child: Text(
              title,
              style: kBodyTextStyle.copyWith(
                  fontSize: kTitleTextSize,
                  color: Colors.white,
                  fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}
