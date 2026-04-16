import 'package:flutter/material.dart';

class ResponsiveUtils {
  static late MediaQueryData _mediaQueryData;
  static late double screenWidth;
  static late double screenHeight;
  static late double blockSizeHorizontal;
  static late double blockSizeVertical;
  static late double _safeAreaHorizontal;
  static late double _safeAreaVertical;
  static late double safeBlockHorizontal;
  static late double safeBlockVertical;
  static late TextScaler textScaler;
  static late bool isTablet;
  static late bool isPhone;
  static late bool isDesktop;

  // Breakpoints (in logical pixels)
  static const double tabletBreakpoint = 400;
  static const double desktopBreakpoint = 1024;
  static const double largeDesktopBreakpoint = 1440;

  // Max content width used to cap layout on wide screens
  static late double maxContentWidth;

  static void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;

    // Determine device type from width
    isDesktop = screenWidth >= desktopBreakpoint;
    isTablet =
        screenWidth >= tabletBreakpoint && screenWidth < desktopBreakpoint;
    isPhone = !isTablet && !isDesktop;

    // Define a max content width to avoid over-scaling on large screens
    maxContentWidth = isDesktop
        ? (screenWidth >= largeDesktopBreakpoint ? 1200 : 1000)
        : (isTablet ? 900 : screenWidth);

    // Use an effective width capped by maxContentWidth for percentage-based sizing
    final double effectiveWidth =
        screenWidth > maxContentWidth ? maxContentWidth : screenWidth;

    blockSizeHorizontal = effectiveWidth / 100;
    blockSizeVertical = screenHeight / 100;
    _safeAreaHorizontal =
        _mediaQueryData.padding.left + _mediaQueryData.padding.right;
    _safeAreaVertical =
        _mediaQueryData.padding.top + _mediaQueryData.padding.bottom;

    // Cap safe horizontal block as well
    safeBlockHorizontal =
        ((screenWidth > maxContentWidth ? maxContentWidth : screenWidth) -
                _safeAreaHorizontal) /
            100;
    safeBlockVertical = (screenHeight - _safeAreaVertical) / 100;
    textScaler = _mediaQueryData.textScaler;
  }

  // Helper: responsive value per device class
  static T responsiveValue<T>({
    required T mobile,
    T? tablet,
    T? desktop,
  }) {
    if (isDesktop && desktop != null) return desktop;
    if (isTablet && tablet != null) return tablet;
    return mobile;
  }

  // Get responsive height based on percentage of screen height
  static double hp(double percentage) {
    return blockSizeVertical * percentage;
  }

  // Get responsive width based on percentage of screen width
  static double wp(double percentage) {
    return blockSizeHorizontal * percentage;
  }

  // Get responsive font size
  static double fontSize(double size) {
    final double baseSize = blockSizeHorizontal * size * 0.25;
    return textScaler.scale(baseSize);
  }

  // Responsive padding
  static EdgeInsets padding({
    double horizontal = 0,
    double vertical = 0,
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) {
    return EdgeInsets.fromLTRB(
      left > 0 ? wp(left) : wp(horizontal),
      top > 0 ? hp(top) : hp(vertical),
      right > 0 ? wp(right) : wp(horizontal),
      bottom > 0 ? hp(bottom) : hp(vertical),
    );
  }

  // Determine orientation
  static bool get isPortrait => screenHeight > screenWidth;
  static bool get isLandscape => screenWidth > screenHeight;

  // Create responsive sized box
  static Widget verticalSpace(double height) => SizedBox(height: hp(height));
  static Widget horizontalSpace(double width) => SizedBox(width: wp(width));
}
