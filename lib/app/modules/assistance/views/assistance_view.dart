import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/assistance_controller.dart';

class AssistanceView extends GetView<AssistanceController> {
  const AssistanceView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.98),
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: Text(
          'Assistance',
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtils.fontSize(18),
            fontWeight: FontWeight.bold,
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
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(6),
            vertical: ResponsiveUtils.hp(3),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section titre
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                child: Text(
                  "Besoin d'aide ?",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(22),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ),

              // Icône illustration assistance
              Center(
                child: Container(
                  height: ResponsiveUtils.hp(25),
                  width: ResponsiveUtils.wp(70),
                  padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                  margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(4)),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withValues(alpha: 0.05),
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 10,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Icon(
                    Icons.headset_mic,
                    size: ResponsiveUtils.wp(30),
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),

              // Section Coordonnées
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                child: Text(
                  "Nos coordonnées",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(18),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),

              // Carte de contact
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      spreadRadius: 0,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    // Section Email
                    InkWell(
                      onTap: () {
                        // Gestion de l'email (implémentation future)
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.hp(1.5),
                        ),
                        decoration: BoxDecoration(
                          border: Border(
                            bottom: BorderSide(
                              color: Colors.grey.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(2)),
                              ),
                              child: Icon(
                                Icons.email_outlined,
                                color: AppTheme.primaryColor,
                                size: ResponsiveUtils.wp(6),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.wp(4)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Email",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(14),
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                                  Text(
                                    "bussinessgallis@gmail.com",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(14),
                                      color: AppTheme.primaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey.withValues(alpha: 0.5),
                              size: ResponsiveUtils.wp(4),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Section Téléphone
                    InkWell(
                      onTap: () {
                        // Gestion du téléphone (implémentation future)
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          vertical: ResponsiveUtils.hp(1.5),
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                              decoration: BoxDecoration(
                                color: AppTheme.secondaryColor
                                    .withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(2)),
                              ),
                              child: Icon(
                                Icons.phone_outlined,
                                color: AppTheme.secondaryColor,
                                size: ResponsiveUtils.wp(6),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.wp(4)),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Téléphone",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(14),
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                                  Text(
                                    "(221) 77 926 57 36",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(14),
                                      color: AppTheme.secondaryColor,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Icon(
                              Icons.arrow_forward_ios,
                              color: Colors.grey.withValues(alpha: 0.5),
                              size: ResponsiveUtils.wp(4),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Section FAQ
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.help_outline_rounded,
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(6),
                        ),
                        SizedBox(width: ResponsiveUtils.wp(2)),
                        Text(
                          "Foire aux questions",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(16),
                            fontWeight: FontWeight.bold,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: ResponsiveUtils.hp(1)),
                    Text(
                      "Consultez notre FAQ pour trouver des réponses aux questions fréquemment posées.",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(14),
                        color: AppTheme.textPrimaryColor.withValues(alpha: 0.8),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
