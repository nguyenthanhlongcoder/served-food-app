import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class CheckoutHeader extends StatelessWidget {
  const CheckoutHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'payment table #a1'.toUpperCase(),
          style: TextStyle(
              color: Colors.black,
              fontSize: kSubtitleTextSize,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: kPadding,
        ),
        Container(
          padding: EdgeInsets.all(kPadding / 2),
          width: Get.width,
          decoration: BoxDecoration(
            color: Color(0xfff8f8f8),
            border: Border.all(color: kBtnColorStart, width: 2),
            borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'total price'.toUpperCase(),
                    style: TextStyle(
                        color: kBtnColorStart,
                        fontSize: kBodyTextSize,
                        fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: kPadding / 2,
                  ),
                  Text(
                    '12.000.000 VNĐ'.toUpperCase(),
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              Icon(
                Icons.check_circle,
                color: kBtnColorStart,
                size: kIconSize * 1.2,
              )
            ],
          ),
        )
      ],
    );
  }
}
