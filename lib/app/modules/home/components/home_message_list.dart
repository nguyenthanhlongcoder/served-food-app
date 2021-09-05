import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/modules/home/controllers/message_controller.dart';
import 'package:served_food/app/modules/home/widgets/home_message_item.dart';
import 'package:skeletons/skeletons.dart';

class HomeMessageList extends StatelessWidget {
  final MessageController controller = Get.put(MessageController());
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
              onPressed: () => controller.getMessage());
        } else {
          return StreamBuilder(
              stream: controller.getMessage(),
              builder: (context, snapshot) {
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
              });
        }
      }
    });
  }
}
