import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:skeletons/skeletons.dart';

class ProfileHeaderComponent extends StatelessWidget {
  const ProfileHeaderComponent({
    Key key,
    this.user,
  }) : super(key: key);

  final UserModel user;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        top: kPadding,
        right: kPadding,
        left: kPadding,
      ),
      padding:
          EdgeInsets.symmetric(horizontal: kPadding, vertical: kPadding * 2),
      width: Get.width - kPadding * 2,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(kBorderRadius)),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3), // changes position of shadow
            )
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              user.image != null
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: user.image,
                        width: 60,
                        height: 60,
                        fit: BoxFit.cover,
                        placeholder: (context, url) {
                          return SkeletonAvatar();
                        },
                      ),
                    )
                  : SizedBox(
                      height: 50,
                    ),
              SizedBox(
                width: kPadding,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        user.firstName != null
                            ? user.firstName + ' ' + user.lastName
                            : '',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: kSubtitleTextSize,
                            fontWeight: FontWeight.bold),
                      ),
                      Icon(
                        Icons.check_circle,
                        color: Color(0xFF80D510),
                        size: kIconSize,
                      )
                    ],
                  ),
                  SizedBox(
                    height: kPadding / 3,
                  ),
                  Text(
                    user.email ?? '',
                    style: TextStyle(
                        color: kHintColor,
                        fontSize: kBodyTextSize,
                        fontWeight: FontWeight.w400),
                  ),
                ],
              )
            ],
          ),
          SizedBox(
            height: kPadding,
          ),
          Divider(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Role',
                style: TextStyle(
                    color: kHintColor,
                    fontSize: kSubtitleTextSize,
                    fontWeight: FontWeight.w400),
              ),
              user.isSuperuser != null
                  ? Text(
                      user.isSuperuser ? 'Manager' : 'Staff',
                      style: TextStyle(
                          color: Color(0xFFD7892A),
                          fontSize: kSubtitleTextSize,
                          fontWeight: FontWeight.bold),
                    )
                  : SizedBox(
                      width: 0,
                    ),
            ],
          )
        ],
      ),
    );
  }
}
