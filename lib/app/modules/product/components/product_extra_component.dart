import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/product/controllers/extra_controller.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class ProductExtraComponent extends StatelessWidget {
  const ProductExtraComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ExtraController controller = Get.put(ExtraController());
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          'extras'.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kPadding),
        Obx(() {
          if (controller.isDataProcessing.value) {
            return SpinKitFadingFour(
              size: kIconSize,
              color: kBtnColorStart,
            );
          } else {
            if (controller.lstExtra.length == 0) {
              return SizedBox(
                height: 0,
              );
            } else {
              ProductController productController =
                  Get.put(ProductController());
              return Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(controller.lstExtra.length, (index) {
                  return BouncingWidget(
                    onPressed: () {
                      controller.lstSelection[index] =
                          !controller.lstSelection[index];
                      if (controller.lstSelection[index]) {
                        productController.setProductPrice(
                            productController.price.value +
                                controller.lstExtra[index]['price']);

                        productController.extraCart
                            .add(controller.lstExtra[index]['name']);
                        productController.extraOrder
                            .add(controller.lstExtra[index]['id']);
                      } else {
                        productController.setProductPrice(
                            productController.price.value -
                                controller.lstExtra[index]['price']);

                        productController.extraCart.removeWhere((element) =>
                            element == controller.lstExtra[index]['name']);
                        productController.extraOrder.removeWhere((element) =>
                            element == controller.lstExtra[index]['id']);
                      }
                    },
                    child: ProductExtraItem(
                      name: controller.lstExtra[index]['name'],
                      price:
                          formatNumber((controller.lstExtra[index]['price'])),
                      isActive: controller.lstSelection[index],
                      quantityItem: productController.quantityItem.value,
                    ),
                  );
                }),
              );
            }
          }
        })
      ],
    );
  }
}

class ProductExtraItem extends StatelessWidget {
  const ProductExtraItem({
    Key key,
    this.name,
    this.price,
    this.isActive,
    this.quantityItem,
  }) : super(key: key);

  final String name;
  final String price;
  final bool isActive;
  final int quantityItem;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: kPadding,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RichText(
              text: TextSpan(
                  text: name,
                  style: kBodyTextStyle.copyWith(
                      color: Colors.black,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                  children: [
                    TextSpan(
                      text: ' + $price VNĐ',
                      style: kBodyTextStyle.copyWith(
                          color: isActive ? kBtnColorStart : kHintColor,
                          fontSize: kSubtitleTextSize,
                          fontWeight:
                              isActive ? FontWeight.bold : FontWeight.w400),
                    )
                  ]),
            ),
            Row(
              children: [
                Text(
                  quantityItem == 1
                      ? '1 item'
                      : quantityItem.toString() + ' items',
                  style: kBodyTextStyle.copyWith(
                      color: isActive ? Colors.black : kHintColor,
                      fontSize: kSubtitleTextSize,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  width: kPadding,
                ),
                isActive
                    ? Icon(
                        Icons.check,
                        color: kBtnColorStart,
                      )
                    : SizedBox(
                        height: 0,
                      )
              ],
            )
          ],
        ),
        SizedBox(
          height: kPadding,
        ),
        Divider()
      ],
    );
  }
}
