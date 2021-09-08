import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/modules/order/components/order_item_component.dart';
import 'package:served_food/app/modules/order/components/order_price_component.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/widgets/order_clipper.dart';
import 'package:served_food/app/routes/app_routes.dart';

class OrderView extends GetView<OrderController> {
  @override
  Widget build(BuildContext context) {
    controller.updateTableID(Get.arguments['id'].toString());
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
          onPressed: () {
            controller.backToTable(Get.arguments);
          },
        ),
        title: Text(
          Get.arguments['name'],
          style: kBodyTextStyle.copyWith(
              fontSize: kTitleTextSize,
              color: Colors.white,
              fontWeight: FontWeight.w500),
        ),
        actions: [
          TextButton(
              onPressed: () {
                Get.toNamed(AppRoutes.BROWSE);
              },
              child: Text(
                'Order',
                style: kBodyTextStyle.copyWith(
                    fontSize: kSubtitleTextSize,
                    color: Colors.white,
                    fontWeight: FontWeight.w400),
              ))
        ],
        backgroundColor: kBtnColorStart,
      ),
      body: Stack(
        children: [
          ClipPath(
            clipper: OrderClipper(),
            child: Container(
              color: kBtnColorStart,
            ),
          ),
          Positioned(
            top: kPadding,
            child: Column(
              children: [
                OrderPriceComponent(),
                SizedBox(
                  height: kPadding,
                ),
                OrderItemComponent()
              ],
            ),
          ),
          Positioned(
              bottom: 0,
              width: Get.width,
              child: Padding(
                padding: const EdgeInsets.all(kPadding),
                child: GradientBtnWidget(
                  child: BtnTextWhiteWidget(
                    text: 'Checkout',
                  ),
                  onTap: () {},
                ),
              )),
        ],
      ),
    );
  }
}
