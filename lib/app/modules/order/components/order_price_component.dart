import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/controllers/order_controller.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';
import 'package:served_food/app/modules/order/widgets/order_price_item.dart';
import 'package:skeletons/skeletons.dart';

class OrderPriceComponent extends StatelessWidget {
  const OrderPriceComponent({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    OrderController controller = Get.put(OrderController());
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPadding),
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
      child: Padding(
        padding: const EdgeInsets.all(kPadding),
        child: Column(
          children: [
            Obx(() {
              if (controller.isDataProcessing.value) {
                return SpinKitWave(
                  color: kBtnColorStart,
                  size: 30.0,
                );
              } else {
                if (controller.isDataError.value) {
                  return Center(
                    child: FailureLoad(
                      onPressed: () {
                        controller.getOrderDetail();
                      },
                    ),
                  );
                } else {
                  int subTotal = controller.order.value.orderTotalPrice ?? 0;
                  return OrderPriceItem(
                    title: 'Subtotal',
                    price: '$subTotal VNĐ',
                    isTotal: false,
                  );
                }
              }
            }),
            SizedBox(
              height: kPadding,
            ),
            OrderPriceItem(
              title: 'Discount',
              price: '0%',
              isTotal: false,
            ),
            SizedBox(
              height: kPadding,
            ),
            Divider(
              color: Colors.grey.withOpacity(0.7),
            ),
            SizedBox(
              height: kPadding,
            ),
            Obx(() {
              if (controller.isDataProcessing.value) {
                return SpinKitWave(
                  color: kBtnColorStart,
                  size: 30.0,
                );
              } else {
                if (controller.isDataError.value) {
                  return Center(
                    child: FailureLoad(
                      onPressed: () {
                        controller.getOrderDetail();
                      },
                    ),
                  );
                } else {
                  int total = controller.order.value.orderTotalPrice ?? 0;
                  return OrderPriceItem(
                    title: 'Total',
                    price: '$total VNĐ',
                    isTotal: true,
                  );
                }
              }
            }),
          ],
        ),
      ),
    );
  }
}
