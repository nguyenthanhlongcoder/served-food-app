import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/product_filter_item.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/browse/components/browse_filter_appbar.dart';
import 'package:served_food/app/modules/browse/controllers/filter_products_controller.dart';

class BrowseFilterView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    FilterProductsController controller = Get.put(FilterProductsController());
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 120,
        flexibleSpace: BrowseFilterAppBar(
          title: Get.arguments[1] ?? '',
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(
          padding: EdgeInsets.all(kPadding),
          child: Obx(() {
            if (controller.isDataProcessing.value) {
              return Center(
                child: SpinKitWave(
                  color: kBtnColorStart,
                ),
              );
            } else {
              if (controller.isDataError.value) {
                return Center(
                  child: FailureLoad(
                    title: 'Error',
                    message: controller.dataError.value,
                    onPressed: () {
                      controller.getFilterProducts();
                    },
                  ),
                );
              } else {
                List<dynamic> data = [];
                if (Get.arguments[0] == 0) {
                  data.addAll(controller.lstProducts);
                } else {
                  for (var product in controller.lstProducts) {
                    if (product['category']['id'].toString() ==
                        Get.arguments[0]) {
                      data.add(product);
                    }
                  }
                }
                return GridView.count(
                    crossAxisCount: 2,
                    mainAxisSpacing: kPadding / 2,
                    crossAxisSpacing: kPadding / 2,
                    childAspectRatio: 0.8,
                    children: List.generate(data.length, (index) {
                      return ProductFilterItem(
                          title: data[index]['name'],
                          image: data[index]['image'],
                          description: data[index]['description'],
                          price: formatNumber(data[index]
                                  ['product_variation_option'][0]['price']) +
                              ' VNĐ',
                          id: data[index]['id'].toString());
                    }));
              }
            }
          })),
    );
  }
}
