import 'package:flutter/material.dart';
import 'responsive_utils.dart';

class AppTheme {
  // Couleurs principales (Indigo modernisé)
  static const Color primaryColor = Color(0xFF4F46E5); // Indigo 600
  static const Color primaryDark = Color(0xFF3730A3); // Indigo 800
  static const Color primaryLight = Color(0xFF818CF8); // Indigo 400
  static const Color secondaryColor = Color(0xFF0EA5E9); // Sky 500
  static const Color accentColor = Color(0xFFEC4899); // Pink 500

  // Couleurs sémantiques
  static const Color successColor = Color(0xFF22C55E);
  static const Color warningColor = Color(0xFFF59E0B);
  static const Color errorColor = Color(0xFFEF4444);
  static const Color infoColor = Color(0xFF0EA5E9);

  // Couleurs de fond
  static const Color backgroundColor = Color(0xFFF8FAFC); // Slate 50
  static const Color surfaceColor = Color(0xFFFFFFFF);
  static const Color cardColor = Color(0xFFFFFFFF);
  static const Color darkBackgroundColor = Color(0xFF0F172A); // Slate 900

  // Bordures
  static const Color borderColor = Color(0xFFE2E8F0); // Slate 200

  // Couleurs de texte
  static const Color textPrimaryColor = Color(0xFF0F172A); // Slate 900
  static const Color textSecondaryColor = Color(0xFF64748B); // Slate 500
  static const Color textLightColor = Color(0xFFFFFFFF);

  // Rayons de bordure
  static const double radiusSm = 12;
  static const double radiusMd = 16;
  static const double radiusLg = 24;
  static const double radiusXl = 32;

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient accentGradient = LinearGradient(
    colors: [Color(0xFF0EA5E9), Color(0xFF06B6D4)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Shadows (ombres douces et modernes)
  static List<BoxShadow> cardShadow = [
    BoxShadow(
      color: const Color(0xFF1E293B).withValues(alpha: 0.06),
      blurRadius: 16,
      offset: const Offset(0, 6),
    ),
    BoxShadow(
      color: const Color(0xFF1E293B).withValues(alpha: 0.04),
      blurRadius: 6,
      offset: const Offset(0, 2),
    ),
  ];

  static List<BoxShadow> softShadow = [
    BoxShadow(
      color: const Color(0xFF1E293B).withValues(alpha: 0.05),
      blurRadius: 10,
      offset: const Offset(0, 4),
    ),
  ];

  static List<BoxShadow> buttonShadow = [
    BoxShadow(
      color: primaryColor.withValues(alpha: 0.28),
      blurRadius: 16,
      offset: const Offset(0, 8),
    ),
  ];

  // Text Styles
  static TextStyle get headingStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(24),
        fontWeight: FontWeight.w800,
        color: textPrimaryColor,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get subheadingStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(18),
        fontWeight: FontWeight.w600,
        color: textPrimaryColor,
        letterSpacing: -0.2,
      );

  static TextStyle get bodyStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(16),
        color: textSecondaryColor,
        height: 1.5,
      );

  static TextStyle get buttonTextStyle => TextStyle(
        fontSize: ResponsiveUtils.fontSize(16),
        fontWeight: FontWeight.w600,
        color: textLightColor,
        letterSpacing: 0.3,
      );

  // Decoration
  static BoxDecoration get cardDecoration => BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(radiusMd),
        border: Border.all(color: borderColor, width: 1),
        boxShadow: cardShadow,
      );

  static BoxDecoration get gradientCardDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(radiusLg),
        boxShadow: buttonShadow,
      );

  static BoxDecoration get buttonDecoration => BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(radiusMd),
        boxShadow: buttonShadow,
      );
}
