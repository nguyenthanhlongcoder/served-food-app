import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/components/order_item_component.dart';
import 'package:served_food/app/modules/order/components/order_price_component.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/controllers/shopping_cart_controller.dart';
import 'package:served_food/app/modules/order/widgets/cart_item.dart';
import 'package:served_food/app/modules/order/widgets/order_clipper.dart';
import 'package:served_food/app/modules/order/widgets/order_item.dart';
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
              child: Row(
                children: [
                  Container(
                    width: Get.width - 48 - kPadding,
                    padding: const EdgeInsets.all(kPadding),
                    child: GradientBtnWidget(
                      child: BtnTextWhiteWidget(
                        text: 'Checkout',
                      ),
                      onTap: () {},
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Get.bottomSheet(ShoppingCartView(
                        keyOrder: controller.order.value.id.toString(),
                      ));
                    },
                    child: Container(
                      width: 48,
                      height: 48,
                      decoration: BoxDecoration(
                          color: kBtnColorEnd,
                          borderRadius: BorderRadius.all(Radius.circular(48))),
                      child: Icon(
                        Icons.shopping_cart,
                        color: Colors.white,
                      ),
                    ),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

class ShoppingCartView extends StatelessWidget {
  final String keyOrder;

  const ShoppingCartView({Key key, this.keyOrder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ShoppingCartController controller = Get.put(ShoppingCartController());
    controller.updateKey(keyOrder);
    return Container(
        height: Get.height * 0.7,
        padding: EdgeInsets.all(kPadding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kBorderRadius * 2),
                topRight: Radius.circular(kBorderRadius * 2)),
            color: Colors.white),
        child: Obx(() {
          if (controller.isDataProcessing.value) {
            return Center(
              child: SpinKitFadingFour(
                color: kBtnColorStart,
                size: 50,
              ),
            );
          } else {
            return controller.cartItems.length != 0
                ? Stack(children: [
                    ListView.separated(
                        itemBuilder: (context, index) {
                          return CartItem(
                            title: controller.cartItems[index].title,
                            note: controller.cartItems[index].note,
                            image: controller.cartItems[index].image,
                            quantity:
                                controller.cartItems[index].quantity.toString(),
                            price: formatNumber(
                                controller.cartItems[index].orderItemPrice),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return Divider();
                        },
                        itemCount: controller.cartItems.length),
                    Positioned(
                        bottom: 0,
                        width: Get.width - kPadding * 2,
                        child: GradientBtnWidget(
                          onTap: () {
                            controller.addOrderItem();
                          },
                          child: BtnTextWhiteWidget(
                            text: 'Confirm',
                          ),
                        ))
                  ])
                : Center(
                    child: Text(
                      'Nothing',
                      style: kBodyTextStyle.copyWith(
                          color: kBtnColorStart,
                          fontSize: kSubtitleTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  );
          }
        }));
  }
}
