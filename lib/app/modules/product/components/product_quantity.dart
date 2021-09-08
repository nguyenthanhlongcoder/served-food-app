import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';
import 'package:served_food/app/modules/product/widgets/minus_button.dart';
import 'package:served_food/app/modules/product/widgets/plus_button.dart';

class ProductQuantity extends StatelessWidget {
  const ProductQuantity({
    Key key,
    @required this.controller,
  }) : super(key: key);

  final ProductController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'quantity'.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kPadding),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Obx(() {
              return Text(
                controller.quantityItem.value == 1
                    ? '1 item'
                    : controller.quantityItem.value.toString() + ' items',
                style: kBodyTextStyle.copyWith(
                    color: Colors.black,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.bold),
              );
            }),
            Container(
              child: Row(
                children: [
                  MinusButton(),
                  PlusButton(),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
