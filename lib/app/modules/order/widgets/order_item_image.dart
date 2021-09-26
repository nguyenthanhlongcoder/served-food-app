import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:skeletons/skeletons.dart';

class OrderItemImage extends StatelessWidget {
  const OrderItemImage({
    Key key,
    this.image,
    this.isActive,
  }) : super(key: key);
  final String image;
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
      child: CachedNetworkImage(
        imageUrl: image,
        fit: BoxFit.cover,
        width: 80,
        height: 80,
        placeholder: (context, url) {
          return SkeletonAvatar();
        },
      ),
    );
  }
}
