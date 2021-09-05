import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class OrderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, 100);
    path.quadraticBezierTo(Get.width / 2, 200, Get.width, 100);
    path.lineTo(Get.width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return this.hashCode != oldClipper.hashCode;
  }
}
