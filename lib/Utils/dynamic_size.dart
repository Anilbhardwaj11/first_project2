import 'package:flutter/material.dart';

class AppSizes {
  final BuildContext context;
  late double screenWidth;
  late double screenHeight;

  AppSizes(this.context) {
    final size = MediaQuery.of(context).size;
    screenWidth = size.width;
    screenHeight = size.height;
  }

  // Container
  double containerWidth(double factor) => screenWidth * factor;
  double containerHeight(double factor) => screenHeight * factor;

  // SizedBox
  double sizedBoxHeight(double factor) => screenHeight * factor;
  double sizedBoxWidth(double factor) => screenWidth * factor;

  // IconButton size
  double iconSize(double factor) => screenWidth * factor;

  // Button padding
  EdgeInsets buttonPadding() => EdgeInsets.symmetric(
        horizontal: screenWidth * 0.04,
        vertical: screenHeight * 0.015,
      );

  // CircleAvatar radius
  double avatarRadius(double factor) => screenWidth * factor;

  // Text font size
  double fontSize(double factor) => screenWidth * factor;
  EdgeInsets cardPadding({double horizontal = 0.04, double vertical = 0.02}) =>
      EdgeInsets.symmetric(
        horizontal: screenWidth * horizontal,
        vertical: screenHeight * vertical,
      );

  // Card height (optional)
  double cardHeight(double factor) => screenHeight * factor;

  // Card width (optional)
  double cardWidth(double factor) => screenWidth * factor;
}