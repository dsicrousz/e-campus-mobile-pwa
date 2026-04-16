import 'package:flutter/material.dart';
import 'responsive_utils.dart';

class ResponsiveWrapper extends StatelessWidget {
  final Widget child;
  final bool maintainBottomViewPadding;

  const ResponsiveWrapper({
    super.key,
    required this.child,
    this.maintainBottomViewPadding = false,
  });

  @override
  Widget build(BuildContext context) {
    // Initialize the responsive utilities with the current context
    ResponsiveUtils.init(context);
    final media = MediaQuery.of(context);

    // Clamp text scaling for accessibility while preserving layout integrity
    // Fallback to 1.0 if computation fails
    double currentScale;
    try {
      currentScale = media.textScaler.scale(1.0);
    } catch (_) {
      currentScale = media.textScaler.scale(1.0);
    }
    final clampedScale = currentScale.clamp(0.9, 1.2);

    return MediaQuery(
      data: media.copyWith(
        textScaler: TextScaler.linear(clampedScale),
      ),
      child: SafeArea(
        maintainBottomViewPadding: maintainBottomViewPadding,
        child: child,
      ),
    );
  }
}

// Extension methods for responsive sizing
extension ResponsiveExtension on num {
  double get h => ResponsiveUtils.hp(toDouble());
  double get w => ResponsiveUtils.wp(toDouble());
  double get sp => ResponsiveUtils.fontSize(toDouble());
}
