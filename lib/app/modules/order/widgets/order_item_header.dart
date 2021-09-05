import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class OrderItemHeader extends StatelessWidget {
  const OrderItemHeader({
    Key key,
    this.title,
    this.quantity,
  }) : super(key: key);
  final String title;
  final String quantity;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: Text(
            title,
            overflow: TextOverflow.ellipsis,
            style: kBodyTextStyle.copyWith(
                color: Colors.black,
                fontSize: kSubtitleTextSize,
                fontWeight: FontWeight.bold),
          ),
        ),
        RichText(
          text: TextSpan(
              text: 'SL: ',
              style: kBodyTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                    text: quantity,
                    style: kBodyTextStyle.copyWith(
                        color: kBtnColorStart,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.bold))
              ]),
        ),
      ],
    );
  }
}
