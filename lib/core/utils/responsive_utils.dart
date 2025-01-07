import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isMobile(BuildContext context) =>
      MediaQuery.of(context).size.width < 600;

  static bool isTablet(BuildContext context) =>
      MediaQuery.of(context).size.width >= 600 &&
      MediaQuery.of(context).size.width < 1200;

  static bool isDesktop(BuildContext context) =>
      MediaQuery.of(context).size.width >= 1200;

  static double getScreenWidth(BuildContext context) =>
      MediaQuery.of(context).size.width;

  static double getScreenHeight(BuildContext context) =>
      MediaQuery.of(context).size.height;

  static EdgeInsets getResponsivePadding(BuildContext context) {
    if (isMobile(context)) {
      return const EdgeInsets.all(16.0);
    } else if (isTablet(context)) {
      return const EdgeInsets.all(24.0);
    } else {
      return const EdgeInsets.all(32.0);
    }
  }

  static double getResponsiveFontSize(BuildContext context,
      {double baseFontSize = 16}) {
    if (isMobile(context)) {
      return baseFontSize;
    } else if (isTablet(context)) {
      return baseFontSize * 1.2;
    } else {
      return baseFontSize * 1.4;
    }
  }

  static double getHorizontalPadding(double screenWidth) {
    if (screenWidth < 600) return 16;
    if (screenWidth < 1200) return 32;
    return 64;
  }

  static double getMaxContentWidth(double screenWidth) {
    if (screenWidth < 600) return screenWidth - 32;
    if (screenWidth < 1200) return 600;
    return 800;
  }

  static EdgeInsets getScreenPadding(double screenWidth) {
    return EdgeInsets.symmetric(
      horizontal: getHorizontalPadding(screenWidth),
      vertical: 16,
    );
  }
}
