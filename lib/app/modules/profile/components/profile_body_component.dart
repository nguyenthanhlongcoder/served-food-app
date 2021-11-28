import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_datas/user_model.dart';
import 'package:served_food/app/common/app_datas/user_repository.dart';
import 'package:served_food/app/common/app_styles/index.dart';
import 'package:served_food/app/common/providers/log_out.dart';
import 'package:served_food/app/modules/profile/widgets/profile_body_app_item.dart';
import 'package:served_food/app/modules/profile/widgets/profile_body_item.dart';
import 'package:served_food/app/routes/app_routes.dart';

class ProfileBodyComponent extends StatelessWidget {
  const ProfileBodyComponent({
    Key key,
    this.user,
  }) : super(key: key);
  final UserModel user;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPadding),
      padding: EdgeInsets.all(kPadding),
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
        children: [
          ProfileBodyItem(
            title: 'Contact phone',
            content: user.contactPhone,
            isRoute: false,
          ),
          Divider(),
          ProfileBodyItem(
            title: 'My Reports',
            content: 'Analyse and show my reports.',
            isRoute: true,
            onTap: () {
              Get.toNamed(AppRoutes.MY_REPORT);
            },
          ),
          Divider(),
          ProfileBodyItem(
            title: 'Reports',
            content: 'Analyse and show all reports.',
            isRoute: true,
            onTap: () {
              new UserRepository().getUser().then((value) {
                if (value.isSuperuser == true) {
                  Get.toNamed(AppRoutes.REPORT);
                } else {
                  Fluttertoast.showToast(
                      msg: 'This action requires manager role.');
                }
              });
            },
          ),
          Divider(),
          ProfileBodyAppItem(
            icon: 'assets/svg_pictures/call-center-agent.svg',
            title: 'Support',
          ),
          Divider(),
          ProfileBodyAppItem(
            icon: 'assets/svg_pictures/settings.svg',
            title: 'Settings',
          ),
          Divider(),
          ProfileBodyAppItem(
            icon: 'assets/svg_pictures/term.svg',
            title: 'Terms of use',
          ),
          Divider(),
          ProfileBodyAppItem(
            icon: 'assets/svg_pictures/lock.svg',
            title: 'Privacy policy',
          ),
          Divider(),
          ProfileBodyAppItem(
            icon: 'assets/svg_pictures/log-out.svg',
            title: 'Log out',
            onTap: () {
              LogOut().logOut();
            },
          )
        ],
      ),
    );
  }
}
