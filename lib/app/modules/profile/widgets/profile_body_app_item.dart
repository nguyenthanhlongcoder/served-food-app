import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class ProfileBodyAppItem extends StatelessWidget {
  const ProfileBodyAppItem({
    Key key,
    this.title,
    this.icon,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String icon;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onTap,
      child: Padding(
        padding: const EdgeInsets.all(kPadding / 2),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SvgPicture.asset(
                  icon,
                  width: kIconSize,
                  height: kIconSize,
                ),
                SizedBox(
                  width: kPadding / 2,
                ),
                Text(
                  title,
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: kSubtitleTextSize),
                ),
              ],
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: kHintColor,
              size: kIconSize,
            )
          ],
        ),
      ),
    );
  }
}
