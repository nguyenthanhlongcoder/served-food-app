import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/product_model.dart';
import 'package:served_food/app/common/app_datas/variation_option_model.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';
import 'package:served_food/app/modules/product/components/product_variation.dart';

class ProductVariations extends StatefulWidget {
  final ProductController controller;
  final int productVariationOption;
  const ProductVariations(
      {Key key, this.controller, this.productVariationOption})
      : super(key: key);
  @override
  ProductVariationsState createState() {
    return ProductVariationsState();
  }
}

class ProductVariationsState extends State<ProductVariations> {
  @override
  Widget build(BuildContext context) {
    ProductController controller = widget.controller;
    return widget.productVariationOption != 0
        ? Column(
            children: List.generate(
                controller.product.value.variations.length - 1, (index) {
              List<VariationOptionModel> variationOptions = [];

              Variation variation =
                  controller.product.value.variations[++index];
              List<ProductVariationOption> productVariationOptions =
                  controller.product.value.productVariationOptions;
              for (var productVariationOption in productVariationOptions) {
                if (productVariationOption.id ==
                    widget.productVariationOption) {
                  for (var variationOption
                      in productVariationOption.variationOptions) {
                    if (variationOption.variation == variation.id) {
                      variationOptions.add(variationOption);
                    }
                  }
                }
              }

              controller.setVariationName(variation.name);
              controller.setVariationOptions(variationOptions);

              return ProductVariation(index: index);
            }),
          )
        : SizedBox(
            height: 0,
          );
  }
}
