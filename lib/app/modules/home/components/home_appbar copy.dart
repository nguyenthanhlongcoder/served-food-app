import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/modules/home/widgets/search_input.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: kPadding),
      color: kBtnColorStart,
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Browse',
                style: kBodyTextStyle.copyWith(
                    fontSize: kTitleTextSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'Filter',
                style: kBodyTextStyle.copyWith(
                    fontSize: kSubtitleTextSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              )
            ],
          ),
          Container(
              margin: EdgeInsets.symmetric(vertical: kPadding / 2),
              child: SearchInput())
        ],
      ),
    );
  }
}
