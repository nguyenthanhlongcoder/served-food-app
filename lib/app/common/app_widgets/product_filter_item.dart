import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:skeletons/skeletons.dart';

class ProductFilterItem extends StatelessWidget {
  const ProductFilterItem({
    Key key,
    this.title,
    this.description,
    this.id,
    this.price,
    this.image,
  }) : super(key: key);
  final String title;
  final String description;
  final String id;
  final String price;
  final String image;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(AppRoutes.PRODUCT_DETAIL, arguments: id);
      },
      child: Container(
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
                height: 120,
                fit: BoxFit.cover,
                width: Get.width * 0.5,
                placeholder: (context, url) {
                  return SkeletonAvatar();
                },
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                  horizontal: kPadding, vertical: kPadding / 2),
              width: Get.width * 0.5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title ?? '',
                    overflow: TextOverflow.ellipsis,
                    style: kBodyTextStyle.copyWith(
                        fontSize: kBodyTextSize,
                        color: kTextBlackColor,
                        fontWeight: FontWeight.w500),
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
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        price ?? '0 VNĐ',
                        style: kBodyTextStyle.copyWith(
                            fontSize: kBodyTextSize,
                            color: kBtnColorStart,
                            fontWeight: FontWeight.w500),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
