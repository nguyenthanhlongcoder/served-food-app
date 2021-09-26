import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class OrderItemHeader extends StatelessWidget {
  const OrderItemHeader({
    Key key,
    this.title,
    this.quantity,
    this.isActive,
  }) : super(key: key);
  final String title;
  final String quantity;
  final bool isActive;
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
                color: isActive ? Colors.black : Colors.grey,
                fontSize: kSubtitleTextSize,
                fontWeight: FontWeight.bold,
                decoration:
                    isActive ? TextDecoration.none : TextDecoration.lineThrough,
                decorationColor: Colors.red,
                decorationThickness: 2),
          ),
        ),
        RichText(
          text: TextSpan(
              text: 'SL: ',
              style: kBodyTextStyle.copyWith(
                  color: isActive ? Colors.black : Colors.grey,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.bold,
                  decoration: isActive
                      ? TextDecoration.none
                      : TextDecoration.lineThrough,
                  decorationColor: Colors.red,
                  decorationThickness: 2),
              children: [
                TextSpan(
                    text: quantity,
                    style: kBodyTextStyle.copyWith(
                        color: kBtnColorStart,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.bold,
                        decoration: isActive
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationThickness: 2))
              ]),
        ),
      ],
    );
  }
}
