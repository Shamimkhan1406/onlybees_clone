import 'package:flutter/material.dart';

class Responsive {
  static double w(BuildContext context) => MediaQuery.of(context).size.width;
  static double h(BuildContext context) => MediaQuery.of(context).size.height;

  static bool isMobile(BuildContext context) => w(context) < 600;
  static bool isTablet(BuildContext context) => w(context) >= 600 && w(context) < 1024;
  static bool isDesktop(BuildContext context) => w(context) >= 1024;

  static double clampWidth(BuildContext context, double value) {
    // scales based on 1440 design width
    final scale = w(context) / 1440;
    return (value * scale).clamp(value * 0.7, value * 1.2);
  }

  static double clampFont(BuildContext context, double size) {
    final scale = w(context) / 1440;
    return (size * scale).clamp(size * 0.8, size * 1.15);
  }
}
