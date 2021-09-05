import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class OrderPriceItem extends StatelessWidget {
  const OrderPriceItem({
    Key key,
    this.title,
    this.price,
    this.isTotal,
  }) : super(key: key);
  final String title;
  final String price;
  final bool isTotal;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title ?? '',
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: isTotal ? kTitleTextSize * 0.7 : kSubtitleTextSize,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400),
        ),
        Text(
          price ?? '',
          style: kBodyTextStyle.copyWith(
              fontSize: isTotal ? kTitleTextSize * 0.7 : kSubtitleTextSize,
              color: isTotal ? Colors.black : kHintColor,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w400),
        ),
      ],
    );
  }
}
