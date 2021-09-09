import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class CartItemHeader extends StatelessWidget {
  const CartItemHeader({
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
          child: RichText(
            text: TextSpan(
                text: title + ' - ' + 'SL: ',
                style: kBodyTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: kBodyTextSize,
                    fontWeight: FontWeight.bold),
                children: [
                  TextSpan(
                      text: quantity,
                      style: kBodyTextStyle.copyWith(
                          color: kBtnColorStart,
                          fontSize: kBodyTextSize,
                          fontWeight: FontWeight.bold))
                ]),
          ),
        ),
      ],
    );
  }
}
