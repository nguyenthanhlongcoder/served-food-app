import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/order/controllers/shopping_cart_controller.dart';
import 'package:served_food/app/modules/order/widgets/cart_item_header.dart';
import 'package:served_food/app/modules/order/widgets/order_item_header.dart';
import 'package:served_food/app/modules/order/widgets/order_item_image.dart';

class CartItem extends StatelessWidget {
  const CartItem({
    Key key,
    this.image,
    this.title,
    this.quantity,
    this.note,
    this.price,
    this.index,
    this.controller,
  }) : super(key: key);
  final String image;
  final String title;
  final String quantity;
  final String note;
  final String price;
  final int index;
  final ShoppingCartController controller;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        OrderItemImage(
          image: image,
        ),
        Container(
          height: 80,
          width: Get.width - kPadding * 4 - 80,
          padding: const EdgeInsets.only(left: kPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CartItemHeader(
                title: title,
                quantity: quantity,
              ),
              Flexible(
                child: Text(
                  note,
                  overflow: TextOverflow.ellipsis,
                  style: kBodyTextStyle.copyWith(
                      color: kHintColor,
                      fontSize: kBodyTextSize,
                      fontWeight: FontWeight.w400),
                ),
              ),
              Text(
                price + ' VNĐ',
                style: kBodyTextStyle.copyWith(
                    color: kBtnColorStart,
                    fontSize: kBodyTextSize,
                    fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        Center(
          child: BouncingWidget(
            onPressed: () {
              controller.removeCartItem(index);
            },
            duration: Duration(milliseconds: 100),
            scaleFactor: 1.5,
            child: Icon(
              Icons.cancel,
              color: kBtnColorStart,
              size: kIconSize,
            ),
          ),
        )
      ],
    );
  }
}
