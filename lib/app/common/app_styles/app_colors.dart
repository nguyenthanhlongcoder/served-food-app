import 'package:flutter/widgets.dart';

const Color kBgColor = Color(0xFFFEDCE0);

const Color kTextColor = Color(0xFF3D0007);

const Color kTextBlackColor = Color(0xFF262628);

const Color kHintColor = Color(0xFF9B9B9B);

const Color kBtnColorStart = Color(0xFFFA6B74);

const Color kBtnColorEnd = Color(0xFFF89500);

const Color kBtnShadowColor = Color(0x33D83131);

const Color kInputBorderColor = Color(0xFFECECEC);

const LinearGradient kBtnLinearGradient = LinearGradient(
  colors: [
    kBtnColorStart,
    kBtnColorEnd,
  ],
);

Color getColorFromHex(String hexColor) {
  hexColor = hexColor.replaceFirst("#", "");
  if (hexColor.length == 6) {
    hexColor = "FF" + hexColor;
  }
  if (hexColor.length == 8) {
    return Color(int.parse("0x$hexColor"));
  }
}
