import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class ProductTitle extends StatelessWidget {
  const ProductTitle({
    Key key,
    this.title,
  }) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: kBodyTextStyle.copyWith(
          color: Colors.black,
          fontSize: kTitleTextSize,
          fontWeight: FontWeight.bold),
    );
  }
}
