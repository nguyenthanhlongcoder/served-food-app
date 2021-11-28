import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/modules/report/controllers/report_controller.dart';
import 'package:served_food/app/modules/report/models/product_ranking_model.dart';
import 'package:served_food/app/modules/report/models/user_ranking_model.dart';
import 'package:served_food/app/modules/report/widgets/report_product_ranking_widget.dart';
import 'package:served_food/app/modules/report/widgets/report_user_ranking_widget.dart';

class ReportProductRankingComponent extends StatelessWidget {
  const ReportProductRankingComponent({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ReportController controller = Get.put(ReportController());

    return Container(
      padding: EdgeInsets.all(kPadding),
      decoration: BoxDecoration(
        color: Color(0xFF28304D),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(kPadding),
            bottomRight: Radius.circular(kPadding)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Top product',
            style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
          ),
          SizedBox(
            height: kPadding,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: 2 * (Get.width - kPadding * 2) / 5,
                child: Flexible(
                  child: Text(
                    'Name',
                    style:
                        TextStyle(color: Colors.white, fontSize: kBodyTextSize),
                  ),
                ),
              ),
              Container(
                width: (Get.width - kPadding * 2) / 5,
                child: Text(
                  'Sale',
                  style:
                      TextStyle(color: Colors.white, fontSize: kBodyTextSize),
                ),
              ),
              Container(
                width: (Get.width - kPadding * 2) / 5,
                child: Text(
                  'QTY',
                  textAlign: TextAlign.center,
                  style:
                      TextStyle(color: Colors.white, fontSize: kBodyTextSize),
                ),
              ),
              Flexible(
                child: Container(
                  width: (Get.width - kPadding * 2) / 5,
                  child: Text(
                    '#',
                    textAlign: TextAlign.center,
                    style:
                        TextStyle(color: Colors.white, fontSize: kBodyTextSize),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: kPadding,
          ),
          Obx(() {
            if (controller.lstUserRanking.length != 0) {
              return Column(
                children:
                    List.generate(controller.lstProductRanking.length, (index) {
                  ProductRankingModel productRanking =
                      controller.lstProductRanking[index];
                  return ReportProductRankingWidget(
                    name: productRanking.name,
                    qty: productRanking.qty,
                    totalSale: productRanking.totalSale,
                    rank: ++index,
                  );
                }),
              );
            } else {
              return Center(
                child: SpinKitFadingFour(
                  color: Color(0xFF887BFF),
                  size: kIconSize,
                ),
              );
            }
          })
        ],
      ),
    );
  }
}
