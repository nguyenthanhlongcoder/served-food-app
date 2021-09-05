import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:searchfield/searchfield.dart';
import 'package:served_food/app/modules/browse/controllers/product_slider_controller.dart';

class SearchInput extends StatelessWidget {
  const SearchInput({
    Key key,
    this.productSuggestions,
  }) : super(key: key);
  final List<String> productSuggestions;
  @override
  Widget build(BuildContext context) {
    return SearchField(
      searchInputDecoration: InputDecoration(
        filled: true,
        fillColor: Colors.white,
        hintText: 'Search...',
        hintStyle: kBodyTextStyle.copyWith(
            fontSize: kSubtitleTextSize, color: kHintColor),
        border: kInputBorder,
        focusedBorder: kInputBorder,
        enabledBorder: kInputBorder,
        contentPadding: EdgeInsets.all(kPadding),
        prefixIcon: Container(
            width: kIconBoxSize,
            height: kIconBoxSize,
            alignment: Alignment.center,
            child: Icon(
              Icons.search_sharp,
              color: kHintColor,
            )),
      ),
      searchStyle: kBodyTextStyle.copyWith(
          fontSize: kSubtitleTextSize, color: kTextColor),
      suggestions: productSuggestions,
    );
  }
}
