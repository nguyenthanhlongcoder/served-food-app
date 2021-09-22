import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class ProductVariation extends StatefulWidget {
  const ProductVariation({
    Key key,
    this.index,
  }) : super(key: key);
  final int index;
  @override
  ProductVariationsState createState() {
    return ProductVariationsState();
  }
}

class ProductVariationsState extends State<ProductVariation> {
  int radioValue = 0;
  List<int> variationOptionGroupValue = [];
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    variationOptionGroupValue.clear();
    ProductController controller = Get.put(ProductController());
    for (var variationOption in controller.variationOptions) {
      variationOptionGroupValue.add(variationOption.id);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.variationName.value.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kPadding),
        Column(
            children:
                List.generate(controller.variationOptions.length, (index) {
          return Row(children: [
            Radio(
                activeColor: kBtnColorStart,
                value: radioValue,
                groupValue: variationOptionGroupValue[index],
                onChanged: (value) {
                  setState(() {
                    radioValue = variationOptionGroupValue[index];
                    if (controller.orderVariationOptions.length > 1) {
                      controller.orderVariationOptions[widget.index] =
                          variationOptionGroupValue[index];
                    } else {
                      controller.orderVariationOptions
                          .add(variationOptionGroupValue[index]);
                    }
                  });
                }),
            Text(
              controller.variationOptions[index].name,
              style: kBodyTextStyle.copyWith(
                  color: Colors.black,
                  fontSize: kSubtitleTextSize,
                  fontWeight: FontWeight.bold),
            )
          ]);
        })),
        SizedBox(
          height: kPadding * 2,
        )
      ],
    );
  }
}
