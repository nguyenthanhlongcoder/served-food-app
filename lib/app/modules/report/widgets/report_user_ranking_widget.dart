import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/format_number.dart';
import 'package:served_food/app/modules/report/controllers/report_controller.dart';

class ReportUserRankingWidget extends StatelessWidget {
  const ReportUserRankingWidget({
    Key key,
    this.image,
    this.name,
    this.totalSale,
    this.rank,
  }) : super(key: key);
  final String image;
  final String name;
  final int totalSale;
  final int rank;
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
            width: (Get.width - kPadding * 2) / 2,
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  child: CachedNetworkImage(
                    imageUrl: image,
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  width: kPadding / 2,
                ),
                Flexible(
                  child: Text(
                    name,
                    style:
                        TextStyle(color: Colors.white, fontSize: kBodyTextSize),
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: (Get.width - kPadding * 2) / 4,
            child: Text(
              reduceNumber(totalSale, 2) + ' VND',
              style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
            ),
          ),
          Flexible(
            child: Container(
              width: (Get.width - kPadding * 2) / 4,
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
