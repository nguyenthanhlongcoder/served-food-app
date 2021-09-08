import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_components/failure_load.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/product/components/product_appbar.dart';
import 'package:served_food/app/modules/product/components/product_description.dart';
import 'package:served_food/app/modules/product/components/product_prices.dart';
import 'package:served_food/app/modules/product/components/product_quantity.dart';
import 'package:served_food/app/modules/product/components/product_title.dart';
import 'package:served_food/app/modules/product/components/product_total_price.dart';
import 'package:served_food/app/modules/product/controllers/product_controller.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProductController controller = Get.put(ProductController());
    controller.updateID(Get.arguments.toString());
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        toolbarHeight: 250,
        automaticallyImplyLeading: false,
        flexibleSpace: ProductAppBar(),
      ),
      body: Container(
        height: Get.height,
        padding: EdgeInsets.all(kPadding),
        child: Obx(() {
          if (controller.isDataProcessing.value) {
            return SpinKitFadingFour(
              color: kBtnColorStart,
              size: 50,
            );
          } else {
            if (controller.isDataError.value) {
              return Center(
                child: FailureLoad(
                    title: 'Error',
                    message: controller.dataError.value,
                    onPressed: () {
                      controller.getProductDetail();
                    }),
              );
            } else {
              return SingleChildScrollView(
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ProductTitle(
                        title: controller.product.value.name,
                      ),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      ProductDescription(
                        product: controller.product.value,
                      ),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      ProductPrices(
                        controller: controller,
                      ),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      ProductQuantity(controller: controller),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      TextField(
                        maxLines: 3,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.white,
                          hintText: 'Add some note...',
                          hintStyle: kBodyTextStyle.copyWith(
                              fontSize: kSubtitleTextSize, color: kHintColor),
                          border: kInputBorder,
                          focusedBorder: kInputBorder,
                          enabledBorder: kInputBorder,
                          contentPadding: EdgeInsets.all(kPadding),
                        ),
                      ),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      ProductTotalPrice(
                        totalPrice: formatNumber(controller.totalPrice.value),
                      ),
                      SizedBox(
                        height: kPadding * 2,
                      ),
                      GradientBtnWidget(
                          child: BtnTextWhiteWidget(
                        text: 'Add to table',
                      ))
                    ],
                  ),
                ),
              );
            }
          }
        }),
      ),
    );
  }
}
