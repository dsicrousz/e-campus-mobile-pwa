import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../controllers/qrpage_controller.dart';

class QrpageView extends GetView<QrpageController> {
  const QrpageView({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      appBar: AppBar(
        backgroundColor: AppTheme.primaryColor,
        elevation: 0,
        title: const Text(
          'Mon Code QR',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.5,
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
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(5),
              vertical: ResponsiveUtils.hp(3),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre principal
                Text(
                  'Code QR Étudiant',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(24),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(1)),

                // Sous-titre
                Text(
                  'Présentez ce code pour vous identifier',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(14),
                    fontWeight: FontWeight.w400,
                    color: AppTheme.textSecondaryColor,
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(4)),

                // Carte principale du QR code
                Container(
                  width: double.infinity,
                  margin:
                      EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(2)),
                  padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withValues(alpha: 0.08),
                        blurRadius: 20,
                        spreadRadius: 0,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Informations de l'étudiant
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(4),
                          vertical: ResponsiveUtils.hp(2),
                        ),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              AppTheme.primaryColor,
                              AppTheme.primaryColor.withValues(alpha: 0.8),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Column(
                          children: [
                            // Avatar ou initiales
                            Container(
                              width: ResponsiveUtils.wp(16),
                              height: ResponsiveUtils.wp(16),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.2),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  _getInitials(
                                    controller.compte.etudiant?.prenom ?? '',
                                    controller.compte.etudiant?.nom ?? '',
                                  ),
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.fontSize(20),
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),

                            SizedBox(height: ResponsiveUtils.hp(1.5)),

                            // Nom complet
                            Text(
                              "${controller.compte.etudiant?.prenom ?? ''} ${controller.compte.etudiant?.nom ?? ''}"
                                  .toUpperCase(),
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(18),
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                letterSpacing: 1,
                              ),
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(3)),

                      // QR Code
                      Container(
                        padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppTheme.primaryColor.withValues(alpha: 0.1),
                            width: 2,
                          ),
                        ),
                        child: Hero(
                          tag: "qr_code",
                          child: SizedBox(
                            width: ResponsiveUtils.wp(60),
                            height: ResponsiveUtils.wp(60),
                            child: PrettyQrView.data(
                              data: controller.compte.code ?? "N/A",
                              decoration: const PrettyQrDecoration(
                                shape: PrettyQrSmoothSymbol(
                                  color: AppTheme.primaryColor,
                                ),
                              ),
                              errorCorrectLevel: QrErrorCorrectLevel.H,
                            ),
                          ),
                        ),
                      ),

                      SizedBox(height: ResponsiveUtils.hp(2)),

                      // Badge de sécurité
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(4),
                          vertical: ResponsiveUtils.hp(1),
                        ),
                        decoration: BoxDecoration(
                          color: Colors.green.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.verified_user_rounded,
                              size: ResponsiveUtils.fontSize(16),
                              color: Colors.green,
                            ),
                            SizedBox(width: ResponsiveUtils.wp(2)),
                            Text(
                              'Code Sécurisé',
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(13),
                                fontWeight: FontWeight.w600,
                                color: Colors.green.shade700,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(3)),

                // Instructions d'utilisation
                Container(
                  padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                  decoration: BoxDecoration(
                    color: Colors.blue.shade50,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: Colors.blue.shade100,
                      width: 1,
                    ),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.info_outline_rounded,
                        color: Colors.blue.shade700,
                        size: ResponsiveUtils.fontSize(20),
                      ),
                      SizedBox(width: ResponsiveUtils.wp(3)),
                      Expanded(
                        child: Text(
                          'Placez ce code face au scanner pour valider votre identité',
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(13),
                            fontWeight: FontWeight.w500,
                            color: Colors.blue.shade900,
                            height: 1.4,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Méthode pour obtenir les initiales
  String _getInitials(String prenom, String nom) {
    String initiales = '';
    if (prenom.isNotEmpty) {
      initiales += prenom[0].toUpperCase();
    }
    if (nom.isNotEmpty) {
      initiales += nom[0].toUpperCase();
    }
    return initiales.isEmpty ? 'ET' : initiales;
  }
}
