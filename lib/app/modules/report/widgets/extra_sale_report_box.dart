import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class ExtraSaleReportBox extends StatelessWidget {
  final String number;
  final String bottomText;
  const ExtraSaleReportBox({Key key, this.number, this.bottomText})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 2 - kPadding * 1.2,
      height: 90,
      padding: EdgeInsets.symmetric(vertical: kPadding, horizontal: kPadding),
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
          gradient: kExtraSaleLinearGradient),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Extra Sales',
            style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
          ),
          Text('$number VND',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: kSubtitleTextSize * 0.9,
                  fontWeight: FontWeight.bold)),
          Text(
            bottomText,
            style: TextStyle(color: Colors.white, fontSize: kBodyTextSize),
          ),
        ],
      ),
    );
  }
}
