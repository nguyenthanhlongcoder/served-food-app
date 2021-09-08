import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class ProductPrices extends StatefulWidget {
  const ProductPrices({Key key, @required this.controller}) : super(key: key);

  final ProductController controller;
  ProductPricesState createState() {
    return ProductPricesState();
  }
}

class ProductPricesState extends State<ProductPrices> {
  int radioValue = 0;
  @override
  Widget build(BuildContext context) {
    ProductController controller = widget.controller;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'price'.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kPadding),
        Column(
            children: List.generate(
                controller.product.value.productVariationOption.length,
                (index) {
          return Row(
            children: [
              Radio(
                  activeColor: kBtnColorStart,
                  value: radioValue,
                  groupValue: controller.productVaritionGroupValue[index],
                  onChanged: (value) {
                    setState(() {
                      radioValue = controller.productVaritionGroupValue[index];
                      controller.setProductPrice(controller
                          .product.value.productVariationOption[index].price);

                      controller.setProductTotalPrice();
                      print(controller
                          .product.value.productVariationOption[index].price);
                    });
                  }),
              RichText(
                  text: TextSpan(
                      text: controller
                              .product
                              .value
                              .productVariationOption[index]
                              .variationOption
                              .name +
                          ': ',
                      style: kBodyTextStyle.copyWith(
                          color: Colors.black,
                          fontSize: kSubtitleTextSize,
                          fontWeight: FontWeight.bold),
                      children: [
                    TextSpan(
                        text: formatNumber(controller.product.value
                                .productVariationOption[index].price) +
                            ' VNĐ',
                        style: kBodyTextStyle.copyWith(
                            color: kBtnColorStart,
                            fontSize: kSubtitleTextSize,
                            fontWeight: FontWeight.bold))
                  ])),
            ],
          );
        })),
      ],
    );
  }
}
