import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/report/components/report_product_ranking_component.dart';
import 'package:served_food/app/modules/report/components/report_user_ranking_component.dart';
import 'package:served_food/app/modules/report/controllers/report_controller.dart';
import 'package:served_food/app/modules/report/widgets/cancel_sale_report_box.dart';
import 'package:served_food/app/modules/report/widgets/extra_sale_report_box.dart';
import 'package:served_food/app/modules/report/widgets/product_sale_report_box.dart';
import 'package:served_food/app/modules/report/widgets/total_sale_report_box.dart';
import 'package:served_food/app/modules/report/widgets/report_chart.dart';

class ReportView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ReportController controller = Get.put(ReportController());

    return Scaffold(
        backgroundColor: Color(0xFF19273B),
        appBar: AppBar(
          backgroundColor: Color(0xFF19273B),
          actions: [
            PopupMenuButton(
                color: Color(0xFF28304D),
                onSelected: (value) {
                  controller.updateDurationReport(value);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: kPadding),
                  child: Row(
                    children: [
                      Obx(() {
                        return Text(
                          controller.durationReport.value == 1
                              ? 'Daily'
                              : controller.durationReport.value == 2
                                  ? 'Weekly'
                                  : controller.durationReport.value == 3
                                      ? 'Monthly'
                                      : 'Yearly',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: kSubtitleTextSize,
                          ),
                        );
                      }),
                      Icon(Icons.arrow_drop_down)
                    ],
                  ),
                ),
                itemBuilder: (context) => [
                      PopupMenuItem(
                        child: Text(
                          "Daily",
                          style: TextStyle(color: Colors.white),
                        ),
                        value: 1,
                      ),
                      PopupMenuItem(
                        child: Text("Weekly",
                            style: TextStyle(color: Colors.white)),
                        value: 2,
                      ),
                      PopupMenuItem(
                        child: Text("Monthly",
                            style: TextStyle(color: Colors.white)),
                        value: 3,
                      ),
                      PopupMenuItem(
                        child: Text("Yearly",
                            style: TextStyle(color: Colors.white)),
                        value: 4,
                      )
                    ]),
          ],
          title: Text(
            'Report',
            style: TextStyle(
              color: Colors.white,
              fontSize: kTitleTextSize,
            ),
          ),
        ),
        body: SingleChildScrollView(
            padding: EdgeInsets.all(kPadding),
            child: Obx(() {
              String bottomText = '';
              switch (controller.durationReport.value) {
                case 1:
                  bottomText = 'Today';
                  break;
                case 2:
                  bottomText = 'This week';
                  break;
                case 3:
                  const monthNames = [
                    "January",
                    "February",
                    "March",
                    "April",
                    "May",
                    "June",
                    "July",
                    "August",
                    "September",
                    "October",
                    "November",
                    "December"
                  ];
                  DateTime d = new DateTime.now();
                  bottomText = monthNames[d.month - 1];
                  break;
                case 4:
                  DateTime d = new DateTime.now();
                  bottomText = d.year.toString();
                  break;
                default:
              }
              return Column(
                children: [
                  ReportChart(
                    lstMonth: controller.lstMonth,
                    lstValue: controller.lstValue,
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TotalSaleReportBox(
                          number: reduceNumber(
                              controller.totalSaleReport.value.totalSales, 2),
                          bottomText: bottomText),
                      CancelSaleReportBox(
                          number: reduceNumber(
                              controller.totalSaleReport.value.totalCancelSales,
                              2),
                          bottomText: bottomText),
                    ],
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  ReportUserRankingComponent(),
                  SizedBox(
                    height: kPadding,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ProductSaleReportBox(
                          number: reduceNumber(
                              controller.itemSaleReport.value.totalProductSales,
                              2),
                          bottomText: bottomText),
                      ExtraSaleReportBox(
                          number: reduceNumber(
                              controller.itemSaleReport.value.totalExtraSales,
                              2),
                          bottomText: bottomText),
                    ],
                  ),
                  SizedBox(
                    height: kPadding,
                  ),
                  ReportProductRankingComponent()
                ],
              );
            })));
  }
}
