import 'package:flutter/material.dart';
import 'package:served_food/app/common/app_styles/app_colors.dart';
import 'package:served_food/app/common/app_styles/app_size.dart';
import 'package:served_food/app/common/app_styles/app_text_styles.dart';

class LoginTypeIconWidget extends StatelessWidget {
  const LoginTypeIconWidget({
    Key key,
    this.icon,
  }) : super(key: key);
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Image.asset(
        icon,
        width: 16,
        height: 16,
      ),
    );
  }
}

class LineWidget extends StatelessWidget {
  const LineWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 80,
      child: Divider(color: kTextColor),
    );
  }
}

class LoginBtnWidget extends StatelessWidget {
  const LoginBtnWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 208,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: kBtnShadow,
        borderRadius: BorderRadius.circular(kBtnRadius),
      ),
      alignment: Alignment.center,
      child: Text(
        'Login',
        style: kBtnTextStyle,
      ),
    );
  }
}

class WelcomeHeaderWidget extends StatelessWidget {
  const WelcomeHeaderWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Image.asset('assets/images/bg_welcome_header.png'),
        Positioned(
          top: 175,
          left: 40,
          child: Column(
            children: [
              AppIconWidget(),
              SizedBox(height: 8),
              Text(
                'Served\nFood',
                style: kTitleTextStyle,
              ),
              SizedBox(height: 8),
              Text(
                'Best restaurant\nservice',
                style: kBodyTextStyle,
              ),
            ],
          ),
        )
      ],
    );
  }
}

/// App Icon
class AppIconWidget extends StatelessWidget {
  const AppIconWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: kIconBoxSize,
      height: kIconBoxSize,
      decoration: BoxDecoration(
        color: Colors.white,
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: Image.asset(
        'assets/icons/app_icon.png',
        width: 24,
        height: 32,
      ),
    );
  }
}
