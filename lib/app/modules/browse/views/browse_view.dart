import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/browse/components/browse_appbar.dart';
import 'package:served_food/app/modules/browse/components/browse_slider_component.dart';
import 'package:served_food/app/modules/browse/controllers/category_controller.dart';
import 'package:served_food/app/modules/browse/controllers/product_slider_controller.dart';

class BrowseView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CategoryController controller = Get.put(CategoryController());
    Get.put(ProductSliderController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 140,
        flexibleSpace: BrowseAppBar(),
        automaticallyImplyLeading: false,
      ),
      drawer: Drawer(),
      body: Container(
        padding: EdgeInsets.all(kPadding),
        child: Obx(() {
          if (controller.isDataProcessing.value) {
            return Center(
              child: SpinKitWave(
                color: kBtnColorStart,
                size: 30,
              ),
            );
          } else {
            if (controller.isDataError.value) {
              return Center(
                child: FailureLoad(
                    title: 'Error',
                    message: controller.dataError.value,
                    onPressed: () {
                      controller.getCategories();
                    }),
              );
            } else {
              return SingleChildScrollView(
                child: Column(
                    children:
                        List.generate(controller.lstCategories.length, (index) {
                  return new BrowseSliderComponent(
                      id: controller.lstCategories[index]['id'].toString(),
                      name: controller.lstCategories[index]['name']);
                })),
              );
            }
          }
        }),
      ),
    );
  }
}
