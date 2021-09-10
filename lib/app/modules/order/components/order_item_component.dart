import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/widgets/order_item.dart';

class OrderItemComponent extends StatelessWidget {
  const OrderItemComponent({
    Key key,
    this.controller,
  }) : super(key: key);
  final OrderController controller;
  @override
  Widget build(BuildContext context) {
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
          return SpinKitFadingFour(
            color: kBtnColorStart,
            size: 50.0,
          );
        } else {
          if (controller.isDataError.value) {
            if (controller.dataError.value == 'Not Found') {
              return Center(
                child: Text(
                  'Nothing',
                  style: kBodyTextStyle.copyWith(
                      color: kBtnColorStart,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                ),
              );
            } else {
              return Center(child: FailureLoad(
                onPressed: () {
                  controller.getOrderDetail();
                },
              ));
            }
          } else {
            if (controller.order.value != null) {
              return ListView.separated(
                itemCount: controller.order.value.orderItem != null
                    ? controller.order.value.orderItem.length
                    : 0,
                itemBuilder: (context, index) {
                  return OrderItem(
                    id: controller.order.value.orderItem[index].id,
                    image:
                        controller.order.value.orderItem[index].product.image,
                    title:
                        controller.order.value.orderItem[index].product.name +
                            ' - ' +
                            controller.order.value.orderItem[index]
                                .productVariationOption.variationOption.name,
                    quantity: controller.order.value.orderItem[index].quantity
                        .toString(),
                    note: controller.order.value.orderItem[index].note,
                    price: formatNumber(
                        controller.order.value.orderItem[index].orderItemPrice),
                    user: controller
                            .order.value.orderItem[index].user.lastName +
                        ' ' +
                        controller.order.value.orderItem[index].user.firstName,
                    time: controller.order.value.orderItem[index].createdAt
                        .toString(),
                  );
                },
                separatorBuilder: (context, index) {
                  return Divider();
                },
              );
            } else {
              return Center(
                child: Text(
                  'Nothing',
                  style: kBodyTextStyle.copyWith(
                      color: kBtnColorStart,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                ),
              );
            }
          }
        }
      }),
    );
  }
}
