import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/description.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/modules/promotion/components/promotion_banner.dart';
import 'package:served_food/app/modules/promotion/components/promotion_header.dart';
import 'package:served_food/app/modules/promotion/controllers/promotion_controller.dart';
import 'package:served_food/app/modules/promotion/models/promotion_model.dart';

class PromotionView extends GetView<PromotionController> {
  @override
  Widget build(BuildContext context) {
    controller.updateID(Get.arguments);
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: BackButton(
            color: kBtnColorStart,
          ),
          title: Text(
            'Back',
            style: kBodyTextStyle.copyWith(
                fontSize: kSubtitleTextSize * 1.3,
                color: kBtnColorStart,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: false,
        ),
        body: Obx(() {
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
                  onPressed: () => controller.getPromotionDetail());
            } else {
              PromotionModel promotion = controller.promotion.value;

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: PromotionHeader(promotion: promotion),
                  ),
                  SizedBox(
                    height: kPadding / 2,
                  ),
                  Divider(
                    thickness: 1.2,
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: Description(
                      description: promotion.description,
                    ),
                  ),
                  SizedBox(
                    height: kPadding / 2,
                  ),
                  Divider(
                    thickness: 1.2,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: kPadding),
                    child: PromotionBanner(
                      image: promotion.image,
                    ),
                  )
                ],
              );
            }
          }
        }));
  }
}
