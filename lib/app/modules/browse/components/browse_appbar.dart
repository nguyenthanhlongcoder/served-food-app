import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/modules/browse/controllers/product_slider_controller.dart';
import 'package:served_food/app/modules/browse/widgets/search_input.dart';

class BrowseAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductSliderController controller = Get.put(ProductSliderController());
    return Container(
      padding: EdgeInsets.only(right: kPadding),
      decoration: BoxDecoration(gradient: kBtnLinearGradient),
      child: Column(
        children: [
          Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  BackButton(),
                  Text(
                    'Browse',
                    style: kBodyTextStyle.copyWith(
                        fontSize: kTitleTextSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              TextButton(
                  onPressed: () {},
                  child: Text(
                    'Menu',
                    style: kBodyTextStyle.copyWith(
                        fontSize: kSubtitleTextSize,
                        color: Colors.white,
                        fontWeight: FontWeight.w400),
                  ))
            ],
          ),
          Container(
              margin: EdgeInsets.only(
                  top: kPadding / 2, bottom: kPadding, left: kPadding),
              child: Obx(() {
                if (controller.isDataProcessing.value) {
                  return SearchInput(
                    productSuggestions: [],
                  );
                } else {
                  return SearchInput(
                    productSuggestions: controller.getSuggestions(),
                  );
                }
              }))
        ],
      ),
    );
  }
}
