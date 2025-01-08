import 'package:flutter/material.dart';

class AppTheme {
  // Primary colors
  static const primaryColor = Color(0xFF3A81F1);
  static const primaryLightColor = Color(0xFFBBDEFB);
  static const primaryDarkColor = Color(0xFF1976D2);

  // Secondary colors
  static const secondaryButtonColor = Color(0xFFF5F5F5);
  static const secondaryButtonTextColor = Color(0xFF424242);

  // Background colors
  static const backgroundColor = Color(0xFFFFFFFF);
  static const cardBackgroundColor = Color(0xFFFAFAFA);
  static const surfaceColor = Color(0xFFFFFFFF);

  // Text colors
  static const primaryTextColor = Color(0xFF212121);
  static const secondaryTextColor = Color(0xFF757575);
  static const subtitleTextColor = Color(0xFF9E9E9E);

  // Icon colors
  static const iconColor = Color(0xFF3A81F1);
  static const iconActiveColor = primaryColor;

  // Border colors
  static const borderColor = Color(0xFFE0E0E0);

  // Input decoration theme
  static InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    filled: true,
    fillColor: cardBackgroundColor,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 16,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: borderColor),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: borderColor),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: primaryColor),
    ),
    errorBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Colors.red),
    ),
    prefixIconColor: iconColor,
    suffixIconColor: iconColor,
  );

  // Light Theme
  static ThemeData get lightTheme => ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: primaryColor,
          brightness: Brightness.light,
        ),
        primaryColor: primaryColor,
        scaffoldBackgroundColor: backgroundColor,
        cardColor: surfaceColor,
        iconTheme: const IconThemeData(
          color: iconColor,
        ),
        textTheme: const TextTheme(
          titleLarge: TextStyle(
            color: primaryTextColor,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
            fontWeight: FontWeight.w500,
          ),
          bodyLarge: TextStyle(
            color: primaryTextColor,
            fontSize: 16,
          ),
          bodyMedium: TextStyle(
            color: secondaryTextColor,
            fontSize: 14,
          ),
        ),
        inputDecorationTheme: inputDecorationTheme,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: primaryColor,
            foregroundColor: Colors.white,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: OutlinedButton.styleFrom(
            foregroundColor: primaryColor,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            side: const BorderSide(color: primaryColor),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: primaryColor,
            minimumSize: const Size(0, 48),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
        ),
        appBarTheme: const AppBarTheme(
          backgroundColor: backgroundColor,
          foregroundColor: primaryTextColor,
          elevation: 0,
          centerTitle: true,
          iconTheme: IconThemeData(color: primaryColor),
        ),
        cardTheme: CardTheme(
          color: surfaceColor,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
            side: BorderSide(
              color: borderColor.withOpacity(0.5),
            ),
          ),
        ),
        dividerTheme: DividerThemeData(
          color: borderColor.withOpacity(0.5),
          thickness: 1,
          space: 1,
        ),
        checkboxTheme: CheckboxThemeData(
          fillColor: WidgetStateProperty.resolveWith<Color>((states) {
            if (states.contains(WidgetState.selected)) {
              return primaryColor;
            }
            return borderColor;
          }),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4),
          ),
        ),
      );
}
