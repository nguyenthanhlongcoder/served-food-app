import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/widgets/order_item.dart';
import 'package:toggle_switch/toggle_switch.dart';

class OrderItemComponent extends StatefulWidget {
  const OrderItemComponent({
    Key key,
    this.controller,
  }) : super(key: key);
  final OrderController controller;

  @override
  OrderItemComponentState createState() {
    return OrderItemComponentState();
  }
}

class OrderItemComponentState extends State<OrderItemComponent> {
  bool isViewAll = false;
  @override
  void initState() {
    isViewAll = false;
    super.initState();
  }

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
        if (widget.controller.isDataProcessing.value) {
          return SpinKitFadingFour(
            color: kBtnColorStart,
            size: 50.0,
          );
        } else {
          if (widget.controller.isDataError.value) {
            if (widget.controller.dataError.value == 'Not Found') {
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
                  widget.controller.getOrderDetail();
                },
              ));
            }
          } else {
            if (widget.controller.order.value != null) {
              return Column(
                children: [
                  ToggleSwitch(
                    minWidth: 90.0,
                    initialLabelIndex: isViewAll ? 1 : 0,
                    cornerRadius: 20.0,
                    minHeight: 30,
                    activeFgColor: Colors.white,
                    inactiveBgColor: Colors.grey,
                    inactiveFgColor: Colors.white,
                    totalSwitches: 2,
                    labels: ['Normal', 'All'],
                    activeBgColors: [
                      [Colors.green],
                      [Colors.red]
                    ],
                    onToggle: (index) {
                      setState(() {
                        if (index == 0) {
                          isViewAll = false;
                        } else {
                          isViewAll = true;
                        }
                      });
                    },
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount:
                          widget.controller.order.value.orderItems != null
                              ? widget.controller.order.value.orderItems.length
                              : 0,
                      itemBuilder: (context, index) {
                        String variationOptions = '';
                        for (var item in widget.controller.order.value
                            .orderItems[index].orderItemVariationOptions) {
                          variationOptions += ' - ${item.name}';
                        }
                        String extras = '';
                        for (var item in widget
                            .controller.order.value.orderItems[index].extras) {
                          extras += ' ${item.name}';
                        }
                        List<int> orderItemVariationOptions = [];
                        for (var item in widget.controller.order.value
                            .orderItems[index].orderItemVariationOptions) {
                          orderItemVariationOptions.add(item.id);
                        }
                        if (widget.controller.order.value.orderItems[index]
                            .isActive) {
                          return OrderItem(
                              orderID: widget.controller.order.value.id,
                              userID: widget.controller.order.value
                                  .orderItems[index].user.id,
                              productVariationOptionID: widget
                                  .controller
                                  .order
                                  .value
                                  .orderItems[index]
                                  .productVariationOption
                                  .id,
                              orderItemVariationOptionsID:
                                  orderItemVariationOptions,
                              id: widget
                                  .controller.order.value.orderItems[index].id,
                              image: widget.controller.order.value
                                  .orderItems[index].product.image,
                              title: widget.controller.order.value
                                      .orderItems[index].product.name +
                                  variationOptions,
                              quantity: widget.controller.order.value
                                  .orderItems[index].quantity
                                  .toString(),
                              note: widget.controller.order.value
                                  .orderItems[index].note,
                              price: formatNumber(widget.controller.order.value
                                  .orderItems[index].orderItemPrice),
                              user: widget.controller.order.value
                                      .orderItems[index].user.lastName +
                                  ' ' +
                                  widget.controller.order.value
                                      .orderItems[index].user.firstName,
                              time: widget.controller.order.value.orderItems[index].createdAt.toString(),
                              extras: extras,
                              isActive: widget.controller.order.value.orderItems[index].isActive);
                        } else {
                          if (isViewAll) {
                            return OrderItem(
                                orderID: widget.controller.order.value.id,
                                userID: widget.controller.order.value
                                    .orderItems[index].user.id,
                                productVariationOptionID: widget
                                    .controller
                                    .order
                                    .value
                                    .orderItems[index]
                                    .productVariationOption
                                    .id,
                                orderItemVariationOptionsID:
                                    orderItemVariationOptions,
                                id: widget.controller.order.value
                                    .orderItems[index].id,
                                image: widget.controller.order.value
                                    .orderItems[index].product.image,
                                title: widget.controller.order.value
                                        .orderItems[index].product.name +
                                    variationOptions,
                                quantity: widget.controller.order.value
                                    .orderItems[index].quantity
                                    .toString(),
                                note: widget.controller.order.value
                                    .orderItems[index].note,
                                price: formatNumber(widget
                                    .controller
                                    .order
                                    .value
                                    .orderItems[index]
                                    .orderItemPriceRecord),
                                user: widget.controller.order.value
                                        .orderItems[index].user.lastName +
                                    ' ' +
                                    widget.controller.order.value
                                        .orderItems[index].user.firstName,
                                time: widget.controller.order.value.orderItems[index].createdAt
                                    .toString(),
                                extras: extras,
                                isActive: widget.controller.order.value.orderItems[index].isActive);
                          } else {
                            return SizedBox(
                              height: 0,
                            );
                          }
                        }
                      },
                      separatorBuilder: (context, index) {
                        if (widget.controller.order.value.orderItems[index]
                            .isActive) {
                          return Divider();
                        } else {
                          if (isViewAll) {
                            return Divider();
                          } else {
                            return SizedBox(
                              height: 0,
                            );
                          }
                        }
                      },
                    ),
                  ),
                ],
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
