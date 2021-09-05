import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/app_widgets/product_item.dart';
import 'package:served_food/app/modules/browse/controllers/product_slider_controller.dart';

class BrowseSliderComponent extends StatelessWidget {
  const BrowseSliderComponent({
    Key key,
    this.id,
    this.name,
  }) : super(key: key);
  final String id;
  final String name;

  @override
  Widget build(BuildContext context) {
    ProductSliderController controller = Get.put(ProductSliderController());

    return Container(
      padding: EdgeInsets.only(bottom: kPadding),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name ?? '',
                style: kBodyTextStyle.copyWith(
                    fontSize: kSubtitleTextSize,
                    color: kTextBlackColor,
                    fontWeight: FontWeight.w500),
              ),
              Text(
                'View all',
                style: kBodyTextStyle.copyWith(
                    fontSize: kBodyTextSize,
                    color: kBtnColorStart,
                    fontWeight: FontWeight.w500),
              ),
            ],
          ),
          SizedBox(
            height: kPadding,
          ),
          Obx(() {
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
                      message: controller.dataError.value ?? '',
                      title: 'Error',
                      onPressed: () {
                        controller.getCategoryProducts();
                      }),
                );
              } else {
                List<dynamic> data = [];
                for (var product in controller.lstProducts) {
                  if (product['category']['id'].toString() == id) {
                    data.add(product);
                  }
                }
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(data.length, (index) {
                      return ProductItem(
                        title: data[index]['name'],
                        image: data[index]['image'],
                        description: data[index]['description'],
                        price: data[index]['product_variation_option'][0]
                                    ['price']
                                .toString() +
                            ' VNĐ',
                        labels: data[index]['label'],
                      );
                    }),
                  ),
                );
              }
            }
          })
        ],
      ),
    );
  }
}