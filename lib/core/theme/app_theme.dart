import 'package:flutter/material.dart';

class AppTheme {
  static const primaryColor = Color(0xFF2196F3); // Main blue color
  static const cardBackgroundColor = Color(0xFFF5F5F5);
  static const iconColor = primaryColor; // Use primary color for icons
  static final secondaryButtonColor =
      Colors.blue[50]; // Light blue for secondary buttons
  static const secondaryButtonTextColor = primaryColor;
  static final textGreyColor = Colors.grey[600];
  static const cardIconColor = primaryColor;

  static ThemeData get lightTheme => ThemeData(
        primaryColor: primaryColor,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: primaryColor),
          titleTextStyle: TextStyle(
            color: primaryColor,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        cardTheme: const CardTheme(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
        ),
      );
}
