import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class PlusButton extends StatelessWidget {
  const PlusButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return InkWell(
      onTap: () {
        controller.increment();
      },
      child: Container(
        padding:
            EdgeInsets.symmetric(vertical: kPadding / 3, horizontal: kPadding),
        decoration: BoxDecoration(
            color: kBtnColorStart,
            border: Border.all(color: kBtnColorStart, width: 2),
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(kPadding * 2),
                bottomRight: Radius.circular(kPadding * 2))),
        child: SvgPicture.asset(
          'assets/svg_pictures/plus.svg',
          color: Colors.white,
          width: 20,
          height: 20,
        ),
      ),
    );
  }
}
