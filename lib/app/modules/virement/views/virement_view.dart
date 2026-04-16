import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import '../controllers/virement_controller.dart';

class VirementView extends GetView<VirementController> {
  const VirementView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      body: Container(
        color: AppTheme.backgroundColor,
        child: SafeArea(
          child: Column(
            children: [
              // AppBar personnalisée
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(5),
                  vertical: ResponsiveUtils.hp(2),
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.arrow_back_ios_rounded,
                        color: Colors.white,
                        size: ResponsiveUtils.wp(5),
                      ),
                      onPressed: () => Get.back(),
                    ),
                    Expanded(
                      child: Text(
                        'Faire un transfert',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ResponsiveUtils.fontSize(20),
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    SizedBox(width: ResponsiveUtils.wp(10)),
                  ],
                ),
              ),

              // Corps de la page
              Expanded(
                child: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: ResponsiveUtils.wp(5),
                      vertical: ResponsiveUtils.hp(3),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // En-tête avec icône moderne
                        Center(
                          child: Obx(
                            () => controller.isLoading.value
                                ? Container(
                                    height: ResponsiveUtils.hp(20),
                                    alignment: Alignment.center,
                                    child: SpinKitRing(
                                      color: AppTheme.primaryColor,
                                      size: ResponsiveUtils.wp(15),
                                      lineWidth: 4,
                                    ),
                                  )
                                : TweenAnimationBuilder(
                                    duration: const Duration(milliseconds: 600),
                                    tween: Tween<double>(begin: 0, end: 1),
                                    builder: (context, double value, child) {
                                      return Transform.scale(
                                        scale: value,
                                        child: Opacity(
                                          opacity: value,
                                          child: child,
                                        ),
                                      );
                                    },
                                    child: Container(
                                      width: ResponsiveUtils.wp(35),
                                      height: ResponsiveUtils.wp(35),
                                      padding:
                                          EdgeInsets.all(ResponsiveUtils.wp(6)),
                                      decoration: BoxDecoration(
                                        color: AppTheme.primaryColor,
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: AppTheme.primaryColor
                                                .withValues(alpha: 0.4),
                                            blurRadius: 20,
                                            spreadRadius: 2,
                                            offset: const Offset(0, 8),
                                          ),
                                        ],
                                      ),
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Icon(
                                          Icons.swap_horiz_rounded,
                                          color: AppTheme.primaryColor,
                                          size: ResponsiveUtils.wp(15),
                                        ),
                                      ),
                                    ),
                                  ),
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.hp(3)),

                        // Titre avec sous-titre
                        Column(
                          children: [
                            Text(
                              "Détails du transfert",
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(24),
                                fontWeight: FontWeight.bold,
                                color: AppTheme.textPrimaryColor,
                              ),
                            ),
                            SizedBox(height: ResponsiveUtils.hp(0.5)),
                            Text(
                              "Remplissez les informations ci-dessous",
                              style: TextStyle(
                                fontSize: ResponsiveUtils.fontSize(14),
                                color: AppTheme.textSecondaryColor,
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: ResponsiveUtils.hp(3)),

                        // Section formulaire avec design moderne
                        Container(
                          padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.wp(5)),
                            border: Border.all(
                              color:
                                  AppTheme.primaryColor.withValues(alpha: 0.1),
                              width: 1,
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.08),
                                blurRadius: 15,
                                spreadRadius: 0,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Champ numéro de carte avec label amélioré
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                                    decoration: BoxDecoration(
                                      color: AppTheme.primaryColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(1.5)),
                                    ),
                                    child: Icon(
                                      Icons.credit_card_rounded,
                                      color: AppTheme.primaryColor,
                                      size: ResponsiveUtils.wp(4),
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(2)),
                                  Text(
                                    "Numéro de carte sociale",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(15),
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ResponsiveUtils.hp(1.5)),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundColor
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.wp(3)),
                                  border: Border.all(
                                    color: AppTheme.primaryColor
                                        .withValues(alpha: 0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) => controller.ncs(value),
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.fontSize(16),
                                    fontWeight: FontWeight.w500,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: 'Ex: 2024-0000',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withValues(alpha: 0.6),
                                      fontSize: ResponsiveUtils.fontSize(14),
                                    ),
                                    prefixIcon: Icon(
                                      Icons.person_outline_rounded,
                                      color: AppTheme.primaryColor,
                                      size: ResponsiveUtils.wp(5.5),
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtils.hp(2),
                                      horizontal: ResponsiveUtils.wp(3),
                                    ),
                                  ),
                                ),
                              ),

                              SizedBox(height: ResponsiveUtils.hp(3)),

                              // Champ montant avec design amélioré
                              Row(
                                children: [
                                  Container(
                                    padding:
                                        EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                                    decoration: BoxDecoration(
                                      color: AppTheme.secondaryColor
                                          .withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(1.5)),
                                    ),
                                    child: Icon(
                                      Icons.account_balance_wallet_rounded,
                                      color: AppTheme.secondaryColor,
                                      size: ResponsiveUtils.wp(4),
                                    ),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(2)),
                                  Text(
                                    "Montant à transférer",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(15),
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.textPrimaryColor,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: ResponsiveUtils.hp(1.5)),
                              Container(
                                decoration: BoxDecoration(
                                  color: AppTheme.backgroundColor
                                      .withValues(alpha: 0.3),
                                  borderRadius: BorderRadius.circular(
                                      ResponsiveUtils.wp(3)),
                                  border: Border.all(
                                    color: AppTheme.secondaryColor
                                        .withValues(alpha: 0.2),
                                    width: 1.5,
                                  ),
                                ),
                                child: TextField(
                                  onChanged: (value) {
                                    final v = int.tryParse(value);
                                    if (v != null) controller.montant(v);
                                  },
                                  keyboardType: TextInputType.number,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.fontSize(18),
                                    fontWeight: FontWeight.bold,
                                    color: AppTheme.textPrimaryColor,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: '0',
                                    hintStyle: TextStyle(
                                      color: Colors.grey.withValues(alpha: 0.6),
                                      fontSize: ResponsiveUtils.fontSize(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    prefixIcon: Icon(
                                      Icons.payments_rounded,
                                      color: AppTheme.secondaryColor,
                                      size: ResponsiveUtils.wp(6),
                                    ),
                                    suffixText: 'FCFA',
                                    suffixStyle: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(16),
                                      fontWeight: FontWeight.bold,
                                      color: AppTheme.secondaryColor,
                                    ),
                                    border: InputBorder.none,
                                    contentPadding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtils.hp(2),
                                      horizontal: ResponsiveUtils.wp(3),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: ResponsiveUtils.hp(2)),

                        // Message d'erreur pour solde insuffisant
                        Obx(() {
                          if (controller.isSoldeInsuffisant) {
                            return Container(
                              margin: EdgeInsets.only(
                                bottom: ResponsiveUtils.hp(2),
                              ),
                              padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                              decoration: BoxDecoration(
                                color: Colors.red.withValues(alpha: 0.05),
                                borderRadius:
                                    BorderRadius.circular(ResponsiveUtils.wp(2)),
                                border: Border.all(
                                  color: Colors.red.withValues(alpha: 0.3),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.error_outline_rounded,
                                    color: Colors.red,
                                    size: ResponsiveUtils.wp(5),
                                  ),
                                  SizedBox(width: ResponsiveUtils.wp(2)),
                                  Expanded(
                                    child: Text(
                                      "Solde insuffisant. Votre solde actuel est de ${controller.acceuilController.compte.solde ?? 0} FCFA",
                                      style: TextStyle(
                                        fontSize: ResponsiveUtils.fontSize(13),
                                        color: Colors.red.shade700,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          }
                          return const SizedBox.shrink();
                        }),

                        // Bouton de transfert avec gradient (conditionnel)
                        Obx(() {
                          final isValid = controller.isFormValid;
                          return AnimatedOpacity(
                            opacity: isValid ? 1.0 : 0.5,
                            duration: const Duration(milliseconds: 300),
                            child: Container(
                              width: double.infinity,
                              height: ResponsiveUtils.hp(7),
                              decoration: BoxDecoration(
                                color: isValid
                                    ? AppTheme.primaryColor
                                    : Colors.grey.shade400,
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(4)),
                                boxShadow: isValid
                                    ? [
                                        BoxShadow(
                                          color: AppTheme.primaryColor
                                              .withValues(alpha: 0.4),
                                          blurRadius: 15,
                                          spreadRadius: 0,
                                          offset: const Offset(0, 6),
                                        ),
                                      ]
                                    : [],
                              ),
                              child: ElevatedButton(
                                onPressed: isValid ? controller.send : null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  foregroundColor: Colors.white,
                                  elevation: 0,
                                  shadowColor: Colors.transparent,
                                  disabledBackgroundColor: Colors.transparent,
                                  disabledForegroundColor:
                                      Colors.white.withValues(alpha: 0.7),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveUtils.wp(4)),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.send_rounded,
                                      size: ResponsiveUtils.wp(6),
                                    ),
                                    SizedBox(width: ResponsiveUtils.wp(3)),
                                    Text(
                                      'EFFECTUER LE TRANSFERT',
                                      style: TextStyle(
                                        fontSize: ResponsiveUtils.fontSize(16),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 1.2,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),

                        SizedBox(height: ResponsiveUtils.hp(2)),

                        // Note de sécurité
                        Container(
                          padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                          decoration: BoxDecoration(
                            color: Colors.blue.withValues(alpha: 0.05),
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.wp(2)),
                            border: Border.all(
                              color: Colors.blue.withValues(alpha: 0.2),
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                Icons.info_outline_rounded,
                                color: Colors.blue,
                                size: ResponsiveUtils.wp(5),
                              ),
                              SizedBox(width: ResponsiveUtils.wp(2)),
                              Expanded(
                                child: Text(
                                  "Vérifiez bien les informations avant de valider",
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.fontSize(13),
                                    color: Colors.blue.shade700,
                                    fontWeight: FontWeight.w500,
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
            ],
          ),
        ),
      ),
    );
  }
}
