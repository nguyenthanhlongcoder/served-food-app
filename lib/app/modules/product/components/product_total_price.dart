import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class ProductTotalPrice extends StatelessWidget {
  const ProductTotalPrice({
    Key key,
    this.totalPrice,
  }) : super(key: key);

  final String totalPrice;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'total price'.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        Text(
          totalPrice + ' VNĐ',
          style: kBodyTextStyle.copyWith(
              color: kBtnColorStart,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
