import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class TableItem extends StatelessWidget {
  const TableItem({
    Key key,
    this.title,
    this.color,
  }) : super(key: key);
  final String title;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              boxShadow: kBtnShadow),
          child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(Get.width)),
                  color: color),
              child: SvgPicture.asset(
                'assets/svg_pictures/cutlery.svg',
                color: Colors.white,
                width: 40,
                height: 40,
              )),
        ),
        SizedBox(
          height: kPadding / 3,
        ),
        Text(
          title,
          style: kBodyTextStyle.copyWith(
              fontSize: kSubtitleTextSize,
              color: color,
              fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
