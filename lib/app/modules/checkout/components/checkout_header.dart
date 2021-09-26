import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/models/order_model.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({
    Key key,
    this.tableName,
    this.order,
  }) : super(key: key);
  final String tableName;
  final OrderModel order;
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        RichText(
          text: TextSpan(
              text: 'payment table '.toUpperCase(),
              style: TextStyle(
                  color: Colors.black,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.bold),
              children: [
                TextSpan(
                  text: '#$tableName',
                  style: TextStyle(
                      color: kBtnColorStart,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                )
              ]),
        ),
        SizedBox(
          height: kPadding,
        ),
        Container(
          padding: EdgeInsets.all(kPadding / 2),
          width: Get.width,
          decoration: BoxDecoration(
            color: Color(0xfff8f8f8),
            border: Border.all(color: kBtnColorStart, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'total price'.toUpperCase(),
                    style: TextStyle(
                        color: kBtnColorStart,
                        fontSize: kBodyTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kPadding / 2,
                  ),
                  Text(
                    formatNumber(order.orderTotalPrice) + ' VNĐ',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Icon(
                Icons.check_circle,
                color: kBtnColorStart,
                size: kIconSize * 1.2,
              )
            ],
          ),
        )
      ],
    );
  }
}
