import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';
import 'package:served_food/app/modules/login/controllers/login_controller.dart';
import 'package:served_food/app/modules/login/widgets/login_widget.dart';

class LoginView extends GetView<LoginController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Image.asset('assets/images/bg_login_header.png'),
          Column(
            children: [
              SizedBox(height: 250),
              ClipPath(
                clipper: LoginClipper(),
                child: LoginBodyWidget(
                  usernameController: controller.usernameController,
                  passwordController: controller.passwordController,
                  loginController: controller,
                ),
              ),
            ],
          ),
          Positioned(
            top: 64,
            left: 28,
            child: BackIcon(),
          )
        ],
      ),
    );
  }
}

/// 登录页面内容体
class LoginBodyWidget extends StatelessWidget {
  const LoginBodyWidget({
    this.usernameController,
    this.passwordController,
    this.loginController,
    Key key,
  }) : super(key: key);
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final LoginController loginController;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      width: double.maxFinite,
      padding: EdgeInsets.all(32),
      child: Form(
        autovalidateMode: AutovalidateMode.onUserInteraction,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 50),
            Text(
              'Login',
              style: kTitleTextStyle,
            ),
            SizedBox(height: 20),
            Text(
              'Your Email',
              style: kBodyTextStyle,
            ),
            SizedBox(height: 4),
            LoginInput(
              hintText: 'Email',
              prefixIcon: 'assets/icons/icon_email.png',
              controller: usernameController,
            ),
            SizedBox(height: 16),
            Text(
              'Your Password',
              style: kBodyTextStyle,
            ),
            SizedBox(height: 4),
            LoginInput(
              hintText: 'Password',
              prefixIcon: 'assets/icons/icon_pwd.png',
              obscureText: true,
              controller: passwordController,
            ),
            SizedBox(height: 32),
            LoginBtnIconWidget(
                loginController: loginController,
                onTap: () => loginController.login()),
            SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
