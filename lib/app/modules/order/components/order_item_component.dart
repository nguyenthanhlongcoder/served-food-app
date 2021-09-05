import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/widgets/order_item.dart';

class OrderItemComponent extends StatelessWidget {
  const OrderItemComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return Container(
      height: Get.height / 2,
      margin: EdgeInsets.symmetric(horizontal: kPadding),
      padding: EdgeInsets.all(kPadding),
      width: Get.width - kPadding * 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      child: Obx(() {
        if (controller.isDataProcessing.value) {
          return SpinKitWave(
            color: kBtnColorStart,
            size: 30.0,
          );
        } else {
          if (controller.isDataError.value) {
            return Center(child: FailureLoad(
              onPressed: () {
                controller.getOrderDetail();
              },
            ));
          } else {
            return ListView.separated(
              itemCount: controller.order.value.orderItem != null
                  ? controller.order.value.orderItem.length
                  : 0,
              itemBuilder: (context, index) {
                return OrderItem(
                  image: controller.order.value.orderItem[index].product.image,
                  title: controller.order.value.orderItem[index].product.name +
                      ' - ' +
                      controller.order.value.orderItem[index]
                          .productVariationOption.variationOption.name,
                  quantity: controller.order.value.orderItem[index].quantity
                      .toString(),
                  note: controller.order.value.orderItem[index].note,
                  price: controller.order.value.orderItem[index].orderItemPrice
                      .toString(),
                );
              },
              separatorBuilder: (context, index) {
                return Divider();
              },
            );
          }
        }
      }),
    );
  }
}
