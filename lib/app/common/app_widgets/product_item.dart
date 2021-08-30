import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
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
            child: Image.network(
              'https://served-food.herokuapp.com/media/Pizza_Rau_Cu_400x275.jpg',
              height: 100,
            ),
          ),
          SizedBox(
            height: kPadding / 2,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: kPadding / 2),
            child: Column(
              children: [
                Text(
                  'Pizza Rau Củ',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kTextBlackColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: kPadding / 3,
                ),
                Text(
                  'Pizza Rau Củ',
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kHintColor,
                      fontWeight: FontWeight.w500),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
