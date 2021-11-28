import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class Description extends StatelessWidget {
  const Description({
    Key key,
    this.description,
  }) : super(key: key);

  final String description;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'description'.toUpperCase(),
            style: kBodyTextStyle.copyWith(
                fontSize: kSubtitleTextSize,
                color: kTextBlackColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: kPadding,
          ),
          Text(
            description ?? '',
            style: kBodyTextStyle.copyWith(
                fontSize: kBodyTextSize,
                color: kHintColor,
                fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}
