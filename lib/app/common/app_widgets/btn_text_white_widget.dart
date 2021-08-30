import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class BtnTextWhiteWidget extends StatelessWidget {
  const BtnTextWhiteWidget({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: kBtnTextStyle.copyWith(
        color: Colors.white,
      ),
    );
  }
}
