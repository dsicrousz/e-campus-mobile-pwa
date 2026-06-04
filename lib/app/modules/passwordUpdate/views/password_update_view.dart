import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';

import '../controllers/password_update_controller.dart';

class PasswordUpdateView extends GetView<PasswordUpdateController> {
  const PasswordUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    // Configuration des thèmes pour Pinput
    final defaultPinTheme = PinTheme(
      width: ResponsiveUtils.wp(12),
      height: ResponsiveUtils.wp(12),
      textStyle: TextStyle(
        fontSize: ResponsiveUtils.fontSize(18),
        color: AppTheme.textPrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: AppTheme.surfaceColor,
        border: Border.all(color: AppTheme.borderColor),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
        boxShadow: AppTheme.softShadow,
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.primaryColor, width: 2),
      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryColor.withValues(alpha: 0.3),
          blurRadius: 8,
          spreadRadius: 1,
          offset: const Offset(0, 2),
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.primaryColor),
        borderRadius: BorderRadius.circular(AppTheme.radiusMd),
      ),
    );

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [AppTheme.primaryColor, AppTheme.primaryDark],
            ),
          ),
        ),
        elevation: 0,
        title: Text(
          'Modification du Code Secret',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtils.fontSize(18),
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: Colors.white,
            size: ResponsiveUtils.wp(5),
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // En-tête avec image
              Center(
                child: Obx(() => controller.isLoading.value
                    ? Container(
                        height: ResponsiveUtils.hp(30),
                        alignment: Alignment.center,
                        child: SpinKitWaveSpinner(
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(50),
                          waveColor: AppTheme.secondaryColor,
                          trackColor:
                              AppTheme.accentColor.withValues(alpha: 0.3),
                        ),
                      )
                    : Container(
                        height: ResponsiveUtils.hp(25),
                        width: ResponsiveUtils.wp(70),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withValues(alpha: 0.05),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusLg),
                          boxShadow: AppTheme.softShadow,
                        ),
                        child: Icon(
                          Icons.lock,
                          size: ResponsiveUtils.wp(30),
                          color: AppTheme.primaryColor,
                        ),
                      )),
              ),

              SizedBox(height: ResponsiveUtils.hp(4)),

              // Section du code actuel
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                child: Text(
                  "CODE SECRET ACTUEL",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(15),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(2),
                  horizontal: ResponsiveUtils.wp(3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(color: AppTheme.borderColor, width: 1),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Center(
                  child: Pinput(
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '●',
                    autofocus: true,
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    onChanged: controller.oldPass.call,
                    keyboardType: TextInputType.number,
                    pinAnimationType: PinAnimationType.fade,
                  ),
                ),
              ),

              SizedBox(height: ResponsiveUtils.hp(1)),

              // Section du nouveau code
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                child: Text(
                  "NOUVEAU CODE SECRET",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(15),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(2),
                  horizontal: ResponsiveUtils.wp(3),
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(color: AppTheme.borderColor, width: 1),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: Center(
                  child: Pinput(
                    length: 6,
                    obscureText: true,
                    obscuringCharacter: '●',
                    defaultPinTheme: defaultPinTheme,
                    focusedPinTheme: focusedPinTheme,
                    submittedPinTheme: submittedPinTheme,
                    onChanged: controller.password.call,
                    keyboardType: TextInputType.number,
                    pinAnimationType: PinAnimationType.fade,
                  ),
                ),
              ),

              SizedBox(height: ResponsiveUtils.hp(2)),

              // Bouton de validation
              Container(
                width: double.infinity,
                margin: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(1)),
                child: ElevatedButton(
                  onPressed: controller.changePassword,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primaryColor,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: EdgeInsets.symmetric(
                      vertical: ResponsiveUtils.hp(2),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMd),
                    ),
                  ),
                  child: Text(
                    'VALIDER LE CHANGEMENT',
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(15),
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
