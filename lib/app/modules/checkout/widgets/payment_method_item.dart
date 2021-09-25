import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class PaymentMethodItem extends StatelessWidget {
  const PaymentMethodItem({
    Key key,
    this.icon,
    this.content,
    this.isActive,
    this.onTap,
  }) : super(key: key);
  final String icon;
  final String content;
  final bool isActive;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kPadding / 2, vertical: kPadding / 2),
        width: Get.width,
        decoration: BoxDecoration(
          color: Color(0xFFF8F8F8),
          border: Border.all(
              color: isActive ? kBtnColorStart : Colors.white, width: 2),
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius / 2)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: 40,
                  height: 45,
                ),
                SizedBox(
                  width: kPadding,
                ),
                Container(
                  width: Get.width / 2,
                  child: Text(
                    content,
                    overflow: TextOverflow.ellipsis,
                    softWrap: true,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: kSubtitleTextSize,
                        fontWeight: FontWeight.w500),
                  ),
                ),
              ],
            ),
            isActive
                ? Icon(
                    Icons.check_circle,
                    color: kBtnColorStart,
                    size: kIconSize * 1.2,
                  )
                : SizedBox()
          ],
        ),
      ),
    );
  }
}
