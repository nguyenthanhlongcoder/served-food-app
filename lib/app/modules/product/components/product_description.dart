import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_datas/product_model.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/label_item.dart';

class ProductDescription extends StatelessWidget {
  const ProductDescription({
    Key key,
    this.product,
  }) : super(key: key);
  final ProductModel product;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'description'.toUpperCase(),
          style: kBodyTextStyle.copyWith(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(height: kPadding),
        Text(
          product.description,
          style: kBodyTextStyle.copyWith(
            color: kHintColor,
            fontSize: kBodyTextSize,
          ),
        ),
        SizedBox(height: kPadding),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(product.labels.length, (index) {
              return LabelItem(
                color: product.labels[index]['background_color'].toString(),
                label: product.labels[index]['name'],
              );
            }),
          ),
        )
      ],
    );
  }
}
