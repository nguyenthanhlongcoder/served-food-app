import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search...',
        hintStyle: kBodyTextStyle.copyWith(
            fontSize: kSubtitleTextSize, color: kHintColor),
        border: kInputBorder,
        focusedBorder: kInputBorder,
        enabledBorder: kInputBorder,
        prefixIcon: Container(
            width: kIconBoxSize,
            height: kIconBoxSize,
            alignment: Alignment.center,
            child: Icon(
              Icons.search_sharp,
              color: kHintColor,
            )),
      ),
      style: kBodyTextStyle.copyWith(
          fontSize: kSubtitleTextSize, color: kTextColor),
    );
  }
}
