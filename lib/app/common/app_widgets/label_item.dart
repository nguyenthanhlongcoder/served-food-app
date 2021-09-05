import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class LabelItem extends StatelessWidget {
  const LabelItem({
    Key key,
    this.label,
    this.color,
  }) : super(key: key);

  final String label;
  final String color;
  @override
  Widget build(BuildContext context) {
    return Container(
        padding:
            EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding / 3),
        margin: EdgeInsets.only(right: kPadding / 2),
        decoration: BoxDecoration(
            color: getColorFromHex(color),
            borderRadius: BorderRadius.all(Radius.circular(25))),
        child: Text(
          label,
          style: kBodyTextStyle.copyWith(color: Colors.white),
        ));
  }
}
