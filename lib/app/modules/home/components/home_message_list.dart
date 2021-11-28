import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/modules/home/controllers/message_controller.dart';
import 'package:served_food/app/modules/home/widgets/home_message_item.dart';

class HomeMessageList extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());
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
              onPressed: () => controller.getMessage());
        } else {
          return StreamBuilder(
              stream: controller.getMessage(),
              builder: (context, snapshot) {
                if (controller.lstMessage.length != 0) {
                  return Column(
                      children: controller.lstMessage.map((item) {
                    Color textColor = getColorFromHex(item['text_color']);
                    Color borderColor = getColorFromHex(item['border_color']);
                    return Container(
                      margin: EdgeInsets.only(bottom: kPadding / 2),
                      child: HomeMessageItem(
                        message: item['name'].toString(),
                        textColor: textColor,
                        borderColor: borderColor,
                      ),
                    );
                  }).toList());
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
}
