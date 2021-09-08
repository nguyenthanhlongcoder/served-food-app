import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';
import 'package:skeletons/skeletons.dart';

class ProductAppBar extends StatelessWidget {
  const ProductAppBar({
    Key key,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    return Container(
      child: Stack(
        children: [
          Positioned.fill(
            child: ShaderMask(
                shaderCallback: (rect) {
                  return LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(
                      Rect.fromLTRB(0, 170, rect.width, rect.height));
                },
                blendMode: BlendMode.dstIn,
                child: Obx(() {
                  if (controller.isDataProcessing.value) {
                    return Container(
                      color: Colors.white,
                    );
                  } else {
                    if (controller.isDataError.value) {
                      controller.getProductDetail();
                      return Container(
                        color: Colors.white,
                      );
                    } else {
                      return CachedNetworkImage(
                        fit: BoxFit.cover,
                        imageUrl: controller.product.value.image,
                        placeholder: (context, url) {
                          return SkeletonAvatar();
                        },
                      );
                    }
                  }
                })),
          ),
          Positioned(
              top: 40,
              child: Row(
                children: [
                  BackButton(
                    color: kBtnColorStart,
                  ),
                  Text(
                    'Back',
                    style: kBodyTextStyle.copyWith(
                        color: kBtnColorStart,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.w500),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
