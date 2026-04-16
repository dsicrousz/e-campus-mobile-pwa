import 'package:flutter/material.dart';
import '../utils/app_theme.dart';
import '../utils/responsive_utils.dart';

/// Collection de composants modernes réutilisables pour l'application E-Campus
class ModernComponents {
  
  /// Carte moderne avec ombre et coins arrondis
  static Widget modernCard({
    required Widget child,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
    Color? color,
    double? borderRadius,
  }) {
    return Container(
      padding: padding ?? EdgeInsets.all(ResponsiveUtils.wp(4)),
      margin: margin,
      decoration: BoxDecoration(
        color: color ?? Colors.white,
        borderRadius: BorderRadius.circular(
          borderRadius ?? ResponsiveUtils.wp(4),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: child,
    );
  }

  /// Container avec gradient
  static Widget gradientContainer({
    required Widget child,
    List<Color>? colors,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
    double? borderRadius,
    EdgeInsetsGeometry? padding,
    EdgeInsetsGeometry? margin,
  }) {
    return Container(
      padding: padding,
      margin: margin,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: begin ?? Alignment.topLeft,
          end: end ?? Alignment.bottomRight,
          colors: colors ?? [
            AppTheme.primaryColor,
            AppTheme.primaryColor.withValues(alpha: 0.8),
          ],
        ),
        borderRadius: BorderRadius.circular(
          borderRadius ?? ResponsiveUtils.wp(4),
        ),
      ),
      child: child,
    );
  }

  /// Champ de texte moderne
  static Widget modernTextField({
    required String hintText,
    IconData? prefixIcon,
    String? suffixText,
    TextEditingController? controller,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 4,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        obscureText: obscureText,
        style: TextStyle(
          fontSize: ResponsiveUtils.fontSize(16),
          color: AppTheme.textPrimaryColor,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: Colors.grey.withValues(alpha: 0.7),
            fontSize: ResponsiveUtils.fontSize(14),
          ),
          prefixIcon: prefixIcon != null
              ? Icon(
                  prefixIcon,
                  color: AppTheme.primaryColor,
                  size: ResponsiveUtils.wp(5),
                )
              : null,
          suffixText: suffixText,
          suffixStyle: TextStyle(
            fontSize: ResponsiveUtils.fontSize(16),
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.hp(1.5),
            horizontal: ResponsiveUtils.wp(3),
          ),
        ),
      ),
    );
  }

  /// Bouton principal moderne
  static Widget primaryButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    Color? backgroundColor,
    Color? textColor,
    bool isLoading = false,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: isLoading ? null : onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? AppTheme.primaryColor,
          foregroundColor: textColor ?? Colors.white,
          elevation: 2,
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.hp(2),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
          ),
        ),
        child: isLoading
            ? SizedBox(
                height: ResponsiveUtils.hp(2.5),
                width: ResponsiveUtils.hp(2.5),
                child: const CircularProgressIndicator(
                  color: Colors.white,
                  strokeWidth: 2,
                ),
              )
            : icon != null
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(icon, size: ResponsiveUtils.wp(5)),
                      SizedBox(width: ResponsiveUtils.wp(2)),
                      Text(
                        text,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(15),
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  )
                : Text(
                    text,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(15),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
      ),
    );
  }

  /// Bouton secondaire (outline)
  static Widget secondaryButton({
    required String text,
    required VoidCallback onPressed,
    IconData? icon,
    Color? borderColor,
    Color? textColor,
  }) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: textColor ?? AppTheme.primaryColor,
          side: BorderSide(
            color: borderColor ?? AppTheme.primaryColor,
            width: 2,
          ),
          padding: EdgeInsets.symmetric(
            vertical: ResponsiveUtils.hp(2),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
          ),
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: ResponsiveUtils.wp(5)),
                  SizedBox(width: ResponsiveUtils.wp(2)),
                  Text(
                    text,
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(15),
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1,
                    ),
                  ),
                ],
              )
            : Text(
                text,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(15),
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
      ),
    );
  }

  /// Badge coloré
  static Widget badge({
    required String text,
    Color? backgroundColor,
    Color? textColor,
    IconData? icon,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: ResponsiveUtils.wp(3),
        vertical: ResponsiveUtils.hp(0.8),
      ),
      decoration: BoxDecoration(
        color: backgroundColor ?? AppTheme.primaryColor.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: ResponsiveUtils.fontSize(14),
              color: textColor ?? AppTheme.primaryColor,
            ),
            SizedBox(width: ResponsiveUtils.wp(1)),
          ],
          Text(
            text,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(13),
              fontWeight: FontWeight.w600,
              color: textColor ?? AppTheme.primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  /// Section de titre
  static Widget sectionTitle({
    required String title,
    String? subtitle,
    IconData? icon,
    Color? color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            if (icon != null) ...[
              Icon(
                icon,
                color: color ?? AppTheme.primaryColor,
                size: ResponsiveUtils.wp(6),
              ),
              SizedBox(width: ResponsiveUtils.wp(2)),
            ],
            Text(
              title,
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(18),
                fontWeight: FontWeight.bold,
                color: color ?? AppTheme.textPrimaryColor,
              ),
            ),
          ],
        ),
        if (subtitle != null) ...[
          SizedBox(height: ResponsiveUtils.hp(0.5)),
          Text(
            subtitle,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(14),
              color: AppTheme.textSecondaryColor,
            ),
          ),
        ],
      ],
    );
  }

  /// État vide
  static Widget emptyState({
    required String message,
    IconData? icon,
    String? actionText,
    VoidCallback? onActionPressed,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon ?? Icons.inbox_outlined,
            size: ResponsiveUtils.wp(20),
            color: Colors.grey.withValues(alpha: 0.5),
          ),
          SizedBox(height: ResponsiveUtils.hp(2)),
          Text(
            message,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: ResponsiveUtils.fontSize(16),
              color: Colors.grey.withValues(alpha: 0.8),
              fontWeight: FontWeight.w500,
            ),
          ),
          if (actionText != null && onActionPressed != null) ...[
            SizedBox(height: ResponsiveUtils.hp(3)),
            TextButton(
              onPressed: onActionPressed,
              child: Text(
                actionText,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(14),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.primaryColor,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  /// Avatar avec initiales
  static Widget avatarWithInitials({
    required String firstName,
    required String lastName,
    String? imageUrl,
    double? radius,
    Color? backgroundColor,
    Color? textColor,
  }) {
    String initials = '';
    if (firstName.isNotEmpty) {
      initials += firstName[0].toUpperCase();
    }
    if (lastName.isNotEmpty) {
      initials += lastName[0].toUpperCase();
    }
    if (initials.isEmpty) {
      initials = 'ET';
    }

    return CircleAvatar(
      radius: radius ?? ResponsiveUtils.wp(8),
      backgroundColor: backgroundColor ?? AppTheme.primaryColor,
      foregroundImage: imageUrl != null ? NetworkImage(imageUrl) : null,
      child: Text(
        initials,
        style: TextStyle(
          fontSize: ResponsiveUtils.fontSize(18),
          fontWeight: FontWeight.bold,
          color: textColor ?? Colors.white,
        ),
      ),
    );
  }

  /// Élément de liste moderne
  static Widget listTile({
    required String title,
    String? subtitle,
    IconData? leadingIcon,
    Color? iconColor,
    Widget? trailing,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.03),
            blurRadius: 6,
            spreadRadius: 0,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
          child: Padding(
            padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
            child: Row(
              children: [
                if (leadingIcon != null) ...[
                  Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                    decoration: BoxDecoration(
                      color: (iconColor ?? AppTheme.primaryColor)
                          .withValues(alpha: 0.1),
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(2)),
                    ),
                    child: Icon(
                      leadingIcon,
                      color: iconColor ?? AppTheme.primaryColor,
                      size: ResponsiveUtils.wp(5),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.wp(3)),
                ],
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(15),
                          fontWeight: FontWeight.w600,
                          color: AppTheme.textPrimaryColor,
                        ),
                      ),
                      if (subtitle != null) ...[
                        SizedBox(height: ResponsiveUtils.hp(0.3)),
                        Text(
                          subtitle,
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(13),
                            color: AppTheme.textSecondaryColor,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Dialogue de confirmation moderne
  static Future<bool?> showConfirmDialog({
    required BuildContext context,
    required String title,
    required String message,
    String confirmText = 'Confirmer',
    String cancelText = 'Annuler',
    IconData? icon,
    Color? iconColor,
  }) {
    return showDialog<bool>(
      context: context,
      builder: (context) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
        ),
        child: Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (icon != null) ...[
                Icon(
                  icon,
                  color: iconColor ?? AppTheme.primaryColor,
                  size: ResponsiveUtils.wp(15),
                ),
                SizedBox(height: ResponsiveUtils.hp(2)),
              ],
              Text(
                title,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(18),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),
              Text(
                message,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(15),
                  color: AppTheme.textSecondaryColor,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(3)),
              Row(
                children: [
                  Expanded(
                    child: secondaryButton(
                      text: cancelText,
                      onPressed: () => Navigator.of(context).pop(false),
                    ),
                  ),
                  SizedBox(width: ResponsiveUtils.wp(3)),
                  Expanded(
                    child: primaryButton(
                      text: confirmText,
                      onPressed: () => Navigator.of(context).pop(true),
                      backgroundColor: iconColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
