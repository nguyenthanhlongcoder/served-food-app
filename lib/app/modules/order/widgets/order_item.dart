import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/order/widgets/order_item_header.dart';
import 'package:served_food/app/modules/order/widgets/order_item_image.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key key,
    this.image,
    this.title,
    this.quantity,
    this.note,
    this.price,
  }) : super(key: key);
  final String image;
  final String title;
  final String quantity;
  final String note;
  final String price;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.bottomSheet(BottomSheet(
          image: image,
          title: title,
          quantity: quantity,
          note: note,
          price: price,
        ));
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          OrderItemImage(
            image: image,
          ),
          Container(
            height: 80,
            width: Get.width - kPadding * 5 - 80,
            padding: const EdgeInsets.only(left: kPadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                OrderItemHeader(
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
        ],
      ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    Key key,
    this.image,
    this.title,
    this.quantity,
    this.note,
    this.price,
  }) : super(key: key);
  final String image;
  final String title;
  final quantity;
  final note;
  final price;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height / 3,
      padding: EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kBorderRadius * 2),
              topRight: Radius.circular(kBorderRadius * 2)),
          color: Colors.white),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              OrderItemImage(
                image: image,
              ),
              SizedBox(
                width: kPadding,
              ),
              Flexible(
                child: RichText(
                  text: TextSpan(
                      text: title + ' - SL: ',
                      style: kBodyTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: kSubtitleTextSize,
                          fontWeight: FontWeight.bold),
                      children: [
                        TextSpan(
                            text: quantity,
                            style: kBodyTextStyle.copyWith(
                                color: kBtnColorStart,
                                fontSize: kSubtitleTextSize,
                                fontWeight: FontWeight.bold))
                      ]),
                ),
              ),
            ],
          ),
          SizedBox(
            height: kPadding,
          ),
          Text('Note:',
              style: kBodyTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.bold)),
          SizedBox(
            height: kPadding,
          ),
          Text(note,
              style: kBodyTextStyle.copyWith(
                  color: Colors.black87,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.w400)),
          SizedBox(
            height: kPadding,
          ),
          RichText(
              text: TextSpan(
            text: 'Price: ',
            style: kBodyTextStyle.copyWith(
                color: Colors.black,
                fontSize: kSubtitleTextSize,
                fontWeight: FontWeight.w500),
            children: [
              TextSpan(
                text: price + ' VNĐ',
                style: kBodyTextStyle.copyWith(
                    color: kBtnColorStart,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.w500),
              )
            ],
          ))
        ],
      ),
    );
  }
}
