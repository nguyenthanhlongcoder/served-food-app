import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class MinusButton extends StatelessWidget {
  const MinusButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());

    return InkWell(
      onTap: () {
        controller.decrement();
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: kPadding / 3, horizontal: kPadding),
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: kBtnColorStart, width: 2),
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kPadding * 2),
                bottomLeft: Radius.circular(kPadding * 2))),
        child: SvgPicture.asset(
          'assets/svg_pictures/minus-sign.svg',
          color: kBtnColorStart,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
