import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';

class ReportProductRankingWidget extends StatelessWidget {
  const ReportProductRankingWidget({
    Key key,
    this.name,
    this.totalSale,
    this.rank,
    this.qty,
  }) : super(key: key);
  final String name;
  final int totalSale;
  final int rank;
  final int qty;
  @override
  Widget build(BuildContext context) {
    String stt = '';
    switch (rank % 10) {
      case 1:
        stt = rank.toString() + 'st';
        break;
      case 2:
        stt = rank.toString() + 'nd';
        break;
      case 3:
        stt = rank.toString() + 'rd';
        break;
      default:
        stt = rank.toString() + 'th';
        break;
    }
    return Padding(
      padding: EdgeInsets.only(bottom: kPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 2 * (Get.width - kPadding * 2) / 5,
            child: Flexible(
              child: Text(
                name,
                style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
              ),
            ),
          ),
          Container(
            width: (Get.width - kPadding * 2) / 5,
            child: Text(
              reduceNumber(totalSale, 2) + ' VND',
              style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
            ),
          ),
          Container(
            width: (Get.width - kPadding * 2) / 5,
            child: Text(
              qty.toString(),
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
            ),
          ),
          Flexible(
            child: Container(
              width: (Get.width - kPadding * 2) / 5,
              alignment: Alignment.center,
              child: Text(
                stt,
                style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
              ),
            ),
          )
        ],
      ),
    );
  }
}
