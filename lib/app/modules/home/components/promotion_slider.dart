import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/modules/home/controllers/slider_controller.dart';
import 'package:served_food/app/routes/app_routes.dart';

class PromotionSlider extends StatelessWidget {
  final SliderController controller = Get.put(SliderController());
  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isDataProcessing.value) {
        return Center(
          child: Container(
            margin: EdgeInsets.all(8),
            child: CircularProgressIndicator(),
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
                return CarouselSlider(
                    items: generateSlider(),
                    options: CarouselOptions(
                        autoPlay: true,
                        aspectRatio: 3.0,
                        enlargeCenterPage: true,
                        enlargeStrategy: CenterPageEnlargeStrategy.height));
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
            child: item['image'] != null
                ? Image.network(
                    item['image'],
                    fit: BoxFit.cover,
                    width: Get.width,
                  )
                : Placeholder(),
          ),
        ),
      );
    }).toList();
    return imageSlider;
  }
}
