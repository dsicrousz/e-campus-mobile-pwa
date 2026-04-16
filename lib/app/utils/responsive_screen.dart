import 'package:flutter/material.dart';
import 'responsive_utils.dart';

/// A base widget for creating responsive screens
/// This can be used as a wrapper for all your screen content
class ResponsiveScreen extends StatelessWidget {
  final Widget child;
  final bool scrollable;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final AppBar? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final FloatingActionButtonLocation? floatingActionButtonLocation;
  final bool resizeToAvoidBottomInset;

  const ResponsiveScreen({
    super.key,
    required this.child,
    this.scrollable = true,
    this.padding,
    this.backgroundColor,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.floatingActionButtonLocation,
    this.resizeToAvoidBottomInset = true,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize responsive utilities
    ResponsiveUtils.init(context);

    // Default padding based on screen size
    final defaultPadding = ResponsiveUtils.padding(horizontal: 4);

    // Main content with optional scrolling
    final content = scrollable
        ? SingleChildScrollView(
            physics: const AlwaysScrollableScrollPhysics(),
            child: Padding(
              padding: padding ?? defaultPadding,
              child: child,
            ),
          )
        : Padding(
            padding: padding ?? defaultPadding,
            child: child,
          );

    return Scaffold(
      appBar: appBar,
      backgroundColor: backgroundColor ?? Colors.white,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
      resizeToAvoidBottomInset: resizeToAvoidBottomInset,
      body: content,
    );
  }
}

/// Extension method for easier text styling
extension ResponsiveTextStyle on TextStyle {
  TextStyle get responsive => copyWith(
        fontSize: fontSize != null
            ? ResponsiveUtils.fontSize(fontSize!)
            : ResponsiveUtils.fontSize(14),
      );
}

/// Extension method for easier widget sizing
extension ResponsiveSizing on Widget {
  Widget responsive({
    double? width,
    double? height,
    EdgeInsets? padding,
    EdgeInsets? margin,
  }) {
    return Container(
      width: width != null ? ResponsiveUtils.wp(width) : null,
      height: height != null ? ResponsiveUtils.hp(height) : null,
      padding: padding,
      margin: margin,
      child: this,
    );
  }
}
