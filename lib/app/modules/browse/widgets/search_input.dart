import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:searchfield/searchfield.dart';
import 'package:served_food/app/modules/browse/controllers/filter_products_controller.dart';
import 'package:served_food/app/modules/browse/controllers/product_slider_controller.dart';
import 'package:served_food/app/routes/app_routes.dart';

class SearchInput extends StatefulWidget {
  const SearchInput({
    Key key,
    this.productSuggestions,
  }) : super(key: key);
  final List<String> productSuggestions;
  @override
  SearchInputState createState() {
    return SearchInputState();
  }
}

class SearchInputState extends State<SearchInput> {
  var hasValue = false;
  var _controller = new TextEditingController();

  @override
  void initState() {
    hasValue = false;
    _controller.addListener(() {
      if (_controller.text == '') {
        setState(() {
          hasValue = false;
        });
      } else {
        setState(() {
          hasValue = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    FilterProductsController controller = Get.put(FilterProductsController());

    return SearchField(
      maxSuggestionsInViewPort: 4,
      controller: _controller,
      onTap: (value) {
        for (var product in controller.lstProducts) {
          if (product['name'] == value) {
            Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: product['id']);
          }
        }
      },
      validator: (x) {
        if (!widget.productSuggestions.contains(x) || x.isEmpty) {
          return 'Please Enter a valid State';
        }
        return null;
      },
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
        suffixIcon: Container(
            width: kIconBoxSize,
            height: kIconBoxSize,
            alignment: Alignment.center,
            child: Visibility(
              visible: hasValue,
              child: IconButton(
                icon: Icon(
                  Icons.clear,
                  color: kHintColor,
                ),
                onPressed: () {
                  _controller.clear();
                  setState(() {
                    hasValue = false;
                  });
                },
              ),
            )),
      ),
      searchStyle: kBodyTextStyle.copyWith(
          fontSize: kSubtitleTextSize, color: kTextColor),
      suggestions: widget.productSuggestions,
    );
  }
}
