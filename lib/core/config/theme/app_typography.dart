import 'package:flutter/material.dart';

/// AppTypography configures the typography guidelines for the Vazirmatn font,
/// which is the standard, high-legibility typeface for Persian RTL user interfaces.
/// Heights and tracking have been customized to optimize Persian character rendering.
class AppTypography {
  AppTypography._();

  static const String fontName = 'Vazirmatn';

  /// Standardizes a modern, responsive text theme tailored for Persian layout rhythms.
  static TextTheme createTextTheme(Color textColor) {
    return TextTheme(
      // Display fonts used for large banners and clinic brand metrics
      displayLarge: TextStyle(
        fontFamily: fontName,
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1.5,
      ),
      displayMedium: TextStyle(
        fontFamily: fontName,
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1.5,
      ),
      
      // Headings used for clinic statistics or sections
      headlineLarge: TextStyle(
        fontFamily: fontName,
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: textColor,
        height: 1.5,
      ),
      headlineMedium: TextStyle(
        fontFamily: fontName,
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.5,
      ),
      
      // Title fonts used for card headers and navigation bars
      titleLarge: TextStyle(
        fontFamily: fontName,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: textColor,
        height: 1.5,
      ),
      titleMedium: TextStyle(
        fontFamily: fontName,
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.5,
      ),
      titleSmall: TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.5,
      ),
      
      // Body copy fonts for patient records, symptoms description, and logs
      bodyLarge: TextStyle(
        fontFamily: fontName,
        fontSize: 16,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.6,
      ),
      bodyMedium: TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.6,
      ),
      bodySmall: TextStyle(
        fontFamily: fontName,
        fontSize: 12,
        fontWeight: FontWeight.normal,
        color: textColor,
        height: 1.6,
      ),
      
      // Label fonts for buttons, tags, timestamps, and badges
      labelLarge: TextStyle(
        fontFamily: fontName,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: textColor,
        letterSpacing: 0.0, // Persian doesn't use character tracking gaps
        height: 1.4,
      ),
      labelMedium: TextStyle(
        fontFamily: fontName,
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: textColor,
        height: 1.4,
      ),
    );
  }
}