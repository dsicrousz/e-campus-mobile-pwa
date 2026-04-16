import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  const SplashView({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);
    
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppTheme.primaryColor,
        child: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(5),
                  vertical: ResponsiveUtils.hp(3),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Logo de l'application
                    Container(
                      width: ResponsiveUtils.wp(35),
                      height: ResponsiveUtils.wp(35),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.2),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                      child: ClipOval(
                        child: Image.asset(
                          'assets/logo2.jpeg',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    
                    SizedBox(height: ResponsiveUtils.hp(3)),
                    
                    // Titre de l'application
                    Text(
                      "E-CAMPUS",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ResponsiveUtils.fontSize(26),
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: ResponsiveUtils.hp(1)),
                    
                    // Sous-titre
                    Text(
                      "Votre campus digital",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.9),
                        fontSize: ResponsiveUtils.fontSize(15),
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    
                    SizedBox(height: ResponsiveUtils.hp(5)),
                    
                    // Animation de chargement
                    SpinKitRing(
                      color: Colors.white,
                      size: ResponsiveUtils.wp(12),
                      lineWidth: 4,
                    ),
                    
                    SizedBox(height: ResponsiveUtils.hp(3)),
                    
                    // Message de chargement
                    Text(
                      "Chargement en cours...",
                      style: TextStyle(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontSize: ResponsiveUtils.fontSize(13),
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
