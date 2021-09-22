import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_widgets/btn_text_white_widget.dart';
import 'package:served_food/app/common/app_widgets/gradient_btn_widget.dart';
import 'package:served_food/app/common/providers/log_out.dart';
import 'package:served_food/app/modules/welcome/controllers/welcome_controller.dart';
import 'package:served_food/app/modules/welcome/widgets/welcome_widget.dart';

class WelcomeView extends GetView<WelcomeController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBgColor,
      body: Column(
        children: [
          WelcomeHeaderWidget(),
          GradientBtnWidget(
            onTap: () {
              LogOut().logOut();
            },
            width: 208,
            child: BtnTextWhiteWidget(
              text: 'Sign up',
            ),
          ),
          SizedBox(height: 16),
          GestureDetector(
            child: LoginBtnWidget(),
            onTap: () {
              controller.routeToLogin();
            },
          ),
          SizedBox(height: 16),
          Text(
            'Forgot password?',
            style: TextStyle(
              fontSize: 18,
              color: kTextColor,
            ),
          ),
          SizedBox(height: 54),
          Row(
            children: [
              Spacer(),
              LineWidget(),
              LoginTypeIconWidget(icon: 'assets/icons/logo_ins.png'),
              LoginTypeIconWidget(icon: 'assets/icons/logo_fb.png'),
              LoginTypeIconWidget(icon: 'assets/icons/logo_twitter.png'),
              LineWidget(),
              Spacer(),
            ],
          )
        ],
      ),
    );
  }
}
