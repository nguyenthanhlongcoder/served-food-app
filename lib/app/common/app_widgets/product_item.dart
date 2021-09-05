import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/app_widgets/label_item.dart';
import 'package:skeletons/skeletons.dart';

class ProductItem extends StatelessWidget {
  const ProductItem({
    Key key,
    this.title,
    this.image,
    this.price,
    this.description,
    this.labels,
  }) : super(key: key);
  final String title;
  final String image;
  final String price;
  final String description;
  final List<dynamic> labels;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: EdgeInsets.only(right: kPadding / 2),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kProductItemRadius),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 5,
            offset: Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(kProductItemRadius),
                topRight: Radius.circular(kProductItemRadius)),
            child: CachedNetworkImage(
              imageUrl: image,
              height: 100,
              fit: BoxFit.cover,
              width: Get.width * 0.7,
              placeholder: (context, url) {
                return SkeletonAvatar();
              },
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(
                horizontal: kPadding, vertical: kPadding / 2),
            width: Get.width * 0.7,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        title ?? '',
                        overflow: TextOverflow.ellipsis,
                        style: kBodyTextStyle.copyWith(
                            fontSize: kBodyTextSize,
                            color: kTextBlackColor,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                    Text(
                      price ?? '0 VNĐ',
                      style: kBodyTextStyle.copyWith(
                          fontSize: kBodyTextSize,
                          color: kBtnColorStart,
                          fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
                SizedBox(
                  height: kPadding / 2,
                ),
                Text(
                  description ?? '',
                  overflow: TextOverflow.ellipsis,
                  style: kBodyTextStyle.copyWith(
                      fontSize: kBodyTextSize,
                      color: kHintColor,
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: kPadding / 2,
                ),
                labels.length != 0
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
                          children: labels.map((value) {
                            return LabelItem(
                              label: value['name'],
                              color: value['background_color'],
                            );
                          }).toList(),
                        ),
                      )
                    : SizedBox()
              ],
            ),
          )
        ],
      ),
    );
  }
}
