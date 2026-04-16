import 'package:flutter/material.dart';
import 'responsive_utils.dart';

class AppTheme {
  // Couleurs principales
  static const Color primaryColor = Color(0xFF3F51B5); // Indigo
  static const Color secondaryColor = Color(0xFF03A9F4); // Light Blue
  static const Color accentColor = Color(0xFFFF4081); // Pink

  // Couleurs de fond
  static const Color backgroundColor = Color(0xFFF5F5F5);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF303030);

  // Couleurs de texte
  static const Color textPrimaryColor = Color(0xFF212121);
  static const Color textSecondaryColor = Color(0xFF757575);
  static const Color textLightColor = Color(0xFFFFFFFF);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF3F51B5), Color(0xFF5C6BC0)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF03A9F4), Color(0xFF00BCD4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: Colors.black.withValues(alpha: 0.1),
      blurRadius: 10,
      offset: const Offset(0, 5),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.3),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
  ];

  // Text Styles
  static TextStyle get headingStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(24),
        fontWeight: FontWeight.bold,
        color: textPrimaryColor,
      );

  static TextStyle get subheadingStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(18),
        fontWeight: FontWeight.w500,
        color: textPrimaryColor,
      );

  static TextStyle get bodyStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(16),
        color: textSecondaryColor,
      );

  static TextStyle get buttonTextStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(16),
        fontWeight: FontWeight.w500,
        color: textLightColor,
      );

  // Decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow,
      );

  static BoxDecoration get gradientCardDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: cardShadow,
      );

  static BoxDecoration get buttonDecoration => BoxDecoration(
        gradient: accentGradient,
        borderRadius: BorderRadius.circular(30),
        boxShadow: buttonShadow,
      );
}
