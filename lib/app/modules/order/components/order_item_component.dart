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
                itemCount: controller.order.value.orderItems != null
                    ? controller.order.value.orderItems.length
                    : 0,
                itemBuilder: (context, index) {
                  String variationOptions = '';
                  for (var item in controller.order.value.orderItems[index]
                      .orderItemVariationOptions) {
                    variationOptions += ' - ${item.name}';
                  }
                  String extras = '';
                  for (var item
                      in controller.order.value.orderItems[index].extras) {
                    extras += ' ${item.name}';
                  }
                  List<int> orderItemVariationOptions = [];
                  for (var item in controller.order.value.orderItems[index]
                      .orderItemVariationOptions) {
                    orderItemVariationOptions.add(item.id);
                  }
                  if (controller.order.value.orderItems[index].isActive) {
                    return OrderItem(
                        orderID: controller.order.value.id,
                        userID:
                            controller.order.value.orderItems[index].user.id,
                        productVariationOptionID: controller.order.value
                            .orderItems[index].productVariationOption.id,
                        orderItemVariationOptionsID: orderItemVariationOptions,
                        id: controller.order.value.orderItems[index].id,
                        image: controller
                            .order.value.orderItems[index].product.image,
                        title: controller
                                .order.value.orderItems[index].product.name +
                            variationOptions,
                        quantity: controller
                            .order.value.orderItems[index].quantity
                            .toString(),
                        note: controller.order.value.orderItems[index].note,
                        price: formatNumber(controller
                            .order.value.orderItems[index].orderItemPrice),
                        user: controller
                                .order.value.orderItems[index].user.lastName +
                            ' ' +
                            controller
                                .order.value.orderItems[index].user.firstName,
                        time: controller.order.value.orderItems[index].createdAt
                            .toString(),
                        extras: extras);
                  } else {
                    return SizedBox(
                      height: 0,
                    );
                  }
                },
                separatorBuilder: (context, index) {
                  if (controller.order.value.orderItems[index].isActive) {
                    return Divider();
                  } else {
                    return SizedBox(
                      height: 0,
                    );
                  }
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
