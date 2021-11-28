import 'package:bouncing_widget/bouncing_widget.dart';
import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/index.dart';

class ProfileBodyItem extends StatelessWidget {
  const ProfileBodyItem({
    Key key,
    this.title,
    this.content,
    this.isRoute,
    this.onTap,
  }) : super(key: key);
  final String title;
  final String content;
  final bool isRoute;
  final Function onTap;
  @override
  Widget build(BuildContext context) {
    return BouncingWidget(
      onPressed: onTap,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: kSubtitleTextSize),
              ),
              SizedBox(
                height: kPadding / 3,
              ),
              Text(
                content ?? '',
                style: TextStyle(
                    color: kHintColor,
                    fontWeight: FontWeight.w400,
                    fontSize: kBodyTextSize),
              ),
              SizedBox(
                height: kPadding / 3,
              ),
            ],
          ),
          isRoute
              ? Icon(
                  Icons.arrow_forward_ios_rounded,
                  color: kHintColor,
                  size: kIconSize,
                )
              : SizedBox(
                  width: 0,
                )
        ],
      ),
    );
  }
}
