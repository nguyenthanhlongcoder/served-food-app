import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({
    Key key,
    this.image,
  }) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'banner'.toUpperCase(),
            style: kBodyTextStyle.copyWith(
                fontSize: kSubtitleTextSize,
                color: kTextBlackColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: kPadding,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: image != null
                ? Image.network(
                    image,
                    fit: BoxFit.cover,
                    width: Get.width,
                  )
                : Placeholder(),
          ),
        ],
      ),
    );
  }
}
