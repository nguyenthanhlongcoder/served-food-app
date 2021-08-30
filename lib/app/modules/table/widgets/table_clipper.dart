import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TableClipper extends CustomClipper<Path> {
  // 第一个点
  Point p1 = Point(0.0, 54.0);
  Point c1 = Point(20.0, 25.0);
  Point c2 = Point(81.0, -8.0);
  // 第二个点
  Point p2 = Point(160.0, 20.0);
  Point c3 = Point(216.0, 38.0);
  Point c4 = Point(280.0, 73.0);
  // 第三个点
  Point p3 = Point(280.0, 44.0);
  Point c5 = Point(280.0, -11.0);
  Point c6 = Point(330.0, 8.0);

  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(Get.width / 2, 0);
    path.quadraticBezierTo(Get.width, Get.width / 2, Get.width / 2, Get.width);
    path.quadraticBezierTo(0, Get.width / 2, Get.width / 2, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}
