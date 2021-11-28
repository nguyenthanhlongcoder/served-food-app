import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:skeletons/skeletons.dart';

class PromotionBanner extends StatelessWidget {
  const PromotionBanner({
    Key key,
    this.image,
  }) : super(key: key);

  final String image;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(kPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'banner'.toUpperCase(),
            style: kBodyTextStyle.copyWith(
                fontSize: kSubtitleTextSize,
                color: kTextBlackColor,
                fontWeight: FontWeight.w500),
          ),
          SizedBox(
            height: kPadding,
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            child: image != null
                ? CachedNetworkImage(
                    imageUrl: image,
                    placeholder: (context, url) {
                      return SkeletonAvatar();
                    },
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
