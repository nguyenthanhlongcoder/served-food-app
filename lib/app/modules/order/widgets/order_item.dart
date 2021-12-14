import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/modules/order/controllers/order_item_controller.dart';
import 'package:served_food/app/modules/order/widgets/btn_delete_widget.dart';
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
    this.user,
    this.time,
    this.id,
    this.extras,
    this.orderID,
    this.productVariationOptionID,
    this.userID,
    this.orderItemVariationOptionsID,
    this.isActive,
  }) : super(key: key);
  final String image;
  final String title;
  final String quantity;
  final String note;
  final String price;
  final String user;
  final String time;
  final int id;
  final String extras;
  final int orderID;
  final int productVariationOptionID;
  final int userID;
  final List<int> orderItemVariationOptionsID;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        OrderItemController controller = Get.put(OrderItemController());
        controller.updateOrderItem(orderID, id, userID,
            productVariationOptionID, orderItemVariationOptionsID);
        Get.bottomSheet(BottomSheet(
            image: image,
            title: title,
            quantity: quantity,
            note: note,
            price: price,
            user: user,
            time: time,
            extras: extras,
            id: id));
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            OrderItemImage(
              image: image,
              isActive: isActive,
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
                    isActive: isActive,
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
                  RichText(
                      text: TextSpan(
                          text: 'Extras: ',
                          style: kBodyTextStyle.copyWith(
                              color: isActive ? Colors.black : Colors.grey,
                              fontSize: kBodyTextSize,
                              decoration: isActive
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                              fontWeight: FontWeight.bold),
                          children: [
                        TextSpan(
                          text: extras,
                          style: kBodyTextStyle.copyWith(
                              color: kBtnColorStart,
                              fontSize: kBodyTextSize,
                              decoration: isActive
                                  ? TextDecoration.none
                                  : TextDecoration.lineThrough,
                              decorationColor: Colors.red,
                              decorationThickness: 2,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                  Text(
                    price + ' VNĐ',
                    style: kBodyTextStyle.copyWith(
                        color: kBtnColorStart,
                        fontSize: kBodyTextSize,
                        decoration: isActive
                            ? TextDecoration.none
                            : TextDecoration.lineThrough,
                        decorationColor: Colors.red,
                        decorationThickness: 2,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ],
        ),
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
    this.user,
    this.time,
    this.id,
    this.extras,
  }) : super(key: key);
  final String image;
  final String title;
  final String quantity;
  final String note;
  final String price;
  final String user;
  final String time;
  final int id;
  final String extras;
  @override
  Widget build(BuildContext context) {
    OrderItemController controller = Get.put(OrderItemController());

    return Container(
      height: Get.height * 0.45,
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
              Container(
                height: 80,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 40,
                      width: Get.width - 80 - kPadding * 3,
                      child: RichText(
                        text: TextSpan(
                            text: title + ' - SL: ',
                            style: kBodyTextStyle.copyWith(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            children: [
                              TextSpan(
                                  text: quantity,
                                  style: kBodyTextStyle.copyWith(
                                      color: kBtnColorStart,
                                      fontWeight: FontWeight.bold))
                            ]),
                      ),
                    ),
                    SizedBox(
                      height: kPadding / 2,
                    ),
                    Container(
                      width: Get.width - 80 - kPadding * 3,
                      child: RichText(
                          text: TextSpan(
                              text: 'by ',
                              style: kBodyTextStyle,
                              children: [
                            TextSpan(
                                text: user,
                                style: kBodyTextStyle.copyWith(
                                    fontWeight: FontWeight.bold),
                                children: [
                                  TextSpan(
                                      text: ' at ',
                                      style: kBodyTextStyle,
                                      children: [
                                        TextSpan(
                                            text: time.split('.').first,
                                            style: kBodyTextStyle.copyWith(
                                                fontWeight: FontWeight.bold))
                                      ]),
                                ])
                          ])),
                    )
                  ],
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
            text: 'Extras: ',
            style: kBodyTextStyle.copyWith(
                color: Colors.black,
                fontSize: kSubtitleTextSize,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: extras,
                style: kBodyTextStyle.copyWith(
                    color: kBtnColorStart,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
          SizedBox(
            height: kPadding,
          ),
          RichText(
              text: TextSpan(
            text: 'Price: ',
            style: kBodyTextStyle.copyWith(
                color: Colors.black,
                fontSize: kSubtitleTextSize,
                fontWeight: FontWeight.bold),
            children: [
              TextSpan(
                text: price + ' VNĐ',
                style: kBodyTextStyle.copyWith(
                    color: kBtnColorStart,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.w500),
              )
            ],
          )),
          SizedBox(
            height: kPadding,
          ),
          BtnDeleteWidget(onTap: () {
            Get.defaultDialog(
              title: "Confirm Action",
              middleText: "Are you sure to cancel?",
              contentPadding: EdgeInsets.all(kPadding / 2),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: Text(
                    "Cancel",
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                ),
                ElevatedButton(
                  onPressed: () {
                    controller.deleteOrderItem();
                    Get.back();
                  },
                  child: Text(
                    "Confirm",
                  ),
                  style: ElevatedButton.styleFrom(
                      primary: Colors.green,
                      padding:
                          EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      textStyle: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold)),
                )
              ],
            );
          }, child: Obx(() {
            if (controller.isDataProcessing.value) {
              return Container(
                width: kIconSize,
                height: kIconSize,
                child: CircularProgressIndicator(
                  color: Colors.white,
                ),
              );
            } else {
              if (controller.isDataError.value) {
                Fluttertoast.showToast(msg: controller.dataError.value);
                return BtnTextWhiteWidget(
                  text: 'Remove',
                );
              } else {
                return BtnTextWhiteWidget(
                  text: 'Remove',
                );
              }
            }
          }))
        ],
      ),
    );
  }
}
