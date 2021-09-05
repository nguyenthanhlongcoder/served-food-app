import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class ProductFilterItem extends StatelessWidget {
  const ProductFilterItem({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kProductItemRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kProductItemRadius),
                topRight: Radius.circular(kProductItemRadius)),
            child: CachedNetworkImage(
              imageUrl:
                  'https://served-food.herokuapp.com/media/Pizza_Rau_Cu_400x275.jpg',
              height: 120,
              fit: BoxFit.cover,
              width: Get.width * 0.5,
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: kPadding, vertical: kPadding / 2),
            width: Get.width * 0.5,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Pizza Rau Củ',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: kPadding / 2,
                ),
                Text(
                  'Pizza Rau Củ',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kHintColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: kPadding / 2,
                ),
                Row(
                  children: [
                    Spacer(),
                    Text(
                      '219.000 VNĐ',
                      style: kBodyTextStyle.copyWith(
                          fontSize: kBodyTextSize,
                          color: kBtnColorStart,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
