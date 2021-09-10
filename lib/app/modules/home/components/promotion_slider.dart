import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/home/controllers/slider_controller.dart';
import 'package:served_food/app/routes/app_routes.dart';
import 'package:skeletons/skeletons.dart';

class PromotionSlider extends StatelessWidget {
  final SliderController controller = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDataProcessing.value) {
        return Center(
          child: SpinKitFadingFour(
            color: kBtnColorStart,
            size: 50,
          ),
        );
      } else {
        if (controller.isDataError.value) {
          return FailureLoad(
              title: 'Error',
              message: controller.dataError.value,
              onPressed: () => controller.getPromotion());
        } else {
          return StreamBuilder(
              stream: controller.getPromotion(),
              builder: (context, snapshot) {
                if (controller.lstPromotion.length != 0) {
                  return CarouselSlider(
                      items: generateSlider(),
                      options: CarouselOptions(
                          autoPlay: true,
                          aspectRatio: 3.0,
                          enlargeCenterPage: true,
                          enlargeStrategy: CenterPageEnlargeStrategy.height));
                } else {
                  return Center(
                    child: Text(
                      'Nothing',
                      style: kBodyTextStyle.copyWith(
                          color: kBtnColorStart,
                          fontSize: kSubtitleTextSize,
                          fontWeight: FontWeight.bold),
                    ),
                  );
                }
              });
        }
      }
    });
  }

  List<Widget> generateSlider() {
    List<Widget> imageSlider = controller.lstPromotion.map((item) {
      return Container(
        margin: EdgeInsets.all(5),
        child: InkWell(
          onTap: () {
            Get.toNamed(AppRoutes.PROMOTION, arguments: item['id'].toString());
          },
          child: ClipRRect(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              child: CachedNetworkImage(
                imageUrl: item['image'],
                fit: BoxFit.cover,
                width: Get.width,
                placeholder: (context, url) {
                  return SkeletonAvatar();
                },
              )),
        ),
      );
    }).toList();
    return imageSlider;
  }
}
