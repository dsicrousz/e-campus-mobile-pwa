import 'package:ecampusv2/app/modules/acceuil/views/restaurants_view.dart';
import 'package:ecampusv2/app/modules/pub/views/pub_view.dart';
import 'package:ecampusv2/app/modules/transaction/views/transaction_view.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/sections/qrsection.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/utils/themecontroller.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../controllers/acceuil_controller.dart';

class AcceuilView extends GetView<AcceuilController> {
  AcceuilView({super.key});

  final ThemeController themeController = Get.find();

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: AppTheme.primaryColor,
        centerTitle: true,
        title: Text(
          "Solde Disponible",
          style: TextStyle(
            color: Colors.white,
            fontSize: ResponsiveUtils.fontSize(20),
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.menu_open,
            color: Colors.white,
            size: ResponsiveUtils.wp(6),
          ),
          onPressed: () {
            controller.drawerPageController.toggleDrawer();
          },
        ),
        actions: [
          Obx(
            () => Container(
              margin: EdgeInsets.only(right: ResponsiveUtils.wp(2)),
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
              ),
              child: themeController.isDarkMode.value
                  ? IconButton(
                      onPressed: () => themeController.toggleTheme(),
                      icon: Icon(
                        Icons.light_mode,
                        color: Colors.white,
                        size: ResponsiveUtils.wp(5),
                      ),
                    )
                  : IconButton(
                      onPressed: () => themeController.toggleTheme(),
                      icon: Icon(
                        Icons.dark_mode,
                        color: Colors.white,
                        size: ResponsiveUtils.wp(5),
                      ),
                    ),
            ),
          ),
        ],
      ),
      body: LiquidPullToRefresh(
        color: AppTheme.primaryColor,
        animSpeedFactor: 2.0,
        backgroundColor: Colors.white,
        borderWidth: 0,
        showChildOpacityTransition: true,
        height: ResponsiveUtils.hp(10),
        onRefresh: () async {
          await controller.load();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            children: [
              // Section du solde et QR code avec design amélioré
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(1),
                  horizontal: ResponsiveUtils.wp(2),
                ),
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(ResponsiveUtils.wp(8)),
                    bottomRight: Radius.circular(ResponsiveUtils.wp(8)),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.1),
                      blurRadius: 10,
                      spreadRadius: 0,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    SizedBox(height: ResponsiveUtils.hp(1)),

                    // Solde + QR Code — layout en row avec carte glassmorphism
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(4),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          // --- Carte Solde ---
                          Expanded(
                            child: Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(4),
                                vertical: ResponsiveUtils.hp(2),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(5)),
                                border: Border.all(
                                  color: Colors.white.withValues(alpha: 0.25),
                                  width: 1,
                                ),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Label
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.account_balance_wallet_outlined,
                                        color:
                                            Colors.white.withValues(alpha: 0.8),
                                        size: ResponsiveUtils.wp(4),
                                      ),
                                      SizedBox(width: ResponsiveUtils.wp(1.5)),
                                      Text(
                                        'Mon Solde',
                                        style: TextStyle(
                                          color: Colors.white
                                              .withValues(alpha: 0.8),
                                          fontSize:
                                              ResponsiveUtils.fontSize(12),
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(1)),

                                  // Montant + toggle
                                  Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Obx(() => controller
                                                .isSoldeShow.value
                                            ? Text.rich(
                                                TextSpan(
                                                  children: [
                                                    TextSpan(
                                                      text: _formatSolde(
                                                          controller
                                                              .compte.solde),
                                                      style: TextStyle(
                                                        color: Colors.white,
                                                        fontSize:
                                                            ResponsiveUtils
                                                                .fontSize(28),
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        height: 1.1,
                                                      ),
                                                    ),
                                                    TextSpan(
                                                      text: ' F',
                                                      style: TextStyle(
                                                        color: Colors.white
                                                            .withValues(
                                                                alpha: 0.7),
                                                        fontSize:
                                                            ResponsiveUtils
                                                                .fontSize(16),
                                                        fontWeight:
                                                            FontWeight.w500,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              )
                                            : Text(
                                                '••••••',
                                                style: TextStyle(
                                                  fontSize:
                                                      ResponsiveUtils.fontSize(
                                                          28),
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  letterSpacing: 4,
                                                  height: 1.1,
                                                ),
                                              )),
                                      ),
                                      Obx(() => GestureDetector(
                                            onTap: controller.isSoldeShow.value
                                                ? controller.hideSolde
                                                : controller.showSolde,
                                            child: Container(
                                              padding: EdgeInsets.all(
                                                  ResponsiveUtils.wp(2)),
                                              decoration: BoxDecoration(
                                                color: Colors.white
                                                    .withValues(alpha: 0.15),
                                                shape: BoxShape.circle,
                                              ),
                                              child: FaIcon(
                                                controller.isSoldeShow.value
                                                    ? FontAwesomeIcons.eyeSlash
                                                    : FontAwesomeIcons.eye,
                                                color: Colors.white,
                                                size: ResponsiveUtils.wp(4),
                                              ),
                                            ),
                                          )),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),

                          SizedBox(width: ResponsiveUtils.wp(3)),

                          // --- Carte QR Code ---
                          GestureDetector(
                            onTap: () => Get.toNamed(Routes.QRPAGE),
                            child: Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(5)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black.withValues(alpha: 0.15),
                                    blurRadius: 12,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Container(
                                    width: ResponsiveUtils.wp(18),
                                    height: ResponsiveUtils.wp(18),
                                    padding:
                                        EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(3)),
                                    ),
                                    child: QrSection(compte: controller.compte),
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                                  Text(
                                    'Scanner',
                                    style: TextStyle(
                                      color: AppTheme.primaryColor,
                                      fontSize: ResponsiveUtils.fontSize(10),
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    SizedBox(height: ResponsiveUtils.hp(2)),

                    // Options rapides en haut
                    Container(
                      margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                      padding: EdgeInsets.symmetric(
                        horizontal: ResponsiveUtils.wp(2),
                        vertical: ResponsiveUtils.hp(1),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.15),
                        borderRadius:
                            BorderRadius.circular(ResponsiveUtils.wp(5)),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          // Mes Transactions
                          _buildActionButton(
                            icon: Icons.change_circle,
                            label: 'Transactions',
                            color: AppTheme.accentColor.withValues(alpha: 0.9),
                            onTap: () => Get.toNamed(Routes.ALLTRANSACTIONS),
                          ),

                          // Transfert
                          _buildActionButton(
                            icon: Icons.send,
                            label: 'Transfert',
                            color: AppTheme.secondaryColor,
                            onTap: () => Get.toNamed(Routes.VIREMENT),
                          ),

                          // Signaler carte perdue
                          Obx(() => _buildActionButton(
                                icon: controller.isCartePerdue.value
                                    ? Icons.credit_card
                                    : Icons.credit_card_off,
                                label: controller.isCartePerdue.value
                                    ? 'Retrouvée'
                                    : 'Carte perdue',
                                color: controller.isCartePerdue.value
                                    ? Colors.green
                                    : Colors.red.withValues(alpha: 0.9),
                                onTap: () => _showCartePerduDialog(Get.context!,
                                    controller.isCartePerdue.value),
                              )),
                        ],
                      ),
                    ),

                    // QR Code section
                  ],
                ),
              ),
              // Section des publicités
              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(2),
                  horizontal: ResponsiveUtils.wp(3),
                ),
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
                padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                child: const PubView(),
              ),

              Container(
                margin: EdgeInsets.symmetric(
                  vertical: ResponsiveUtils.hp(2),
                  horizontal: ResponsiveUtils.wp(3),
                ),
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
                padding: EdgeInsets.all(ResponsiveUtils.wp(2)),
                child: const RestaurantsView(),
              ),

              // Section titre des transactions
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: ResponsiveUtils.wp(5),
                  vertical: ResponsiveUtils.hp(1),
                ),
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1)),
                alignment: Alignment.centerLeft,
                child: Text(
                  "Mes Transactions Récentes",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ),

              // Liste des transactions
              Container(
                margin: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(3)),
                constraints: BoxConstraints(
                  minHeight: ResponsiveUtils.hp(40),
                  maxHeight: ResponsiveUtils.hp(60),
                ),
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
                child: const TransactionView(),
              ),

              // Espace en bas
              SizedBox(height: ResponsiveUtils.hp(5)),
            ],
          ),
        ),
      ),
    );
  }

  String _formatSolde(dynamic value) {
    final numVal = value is num ? value : num.tryParse('$value') ?? 0;
    return NumberFormat.decimalPattern().format(numVal);
  }

  void _showCartePerduDialog(BuildContext context, bool estActuellementPerdue) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
          ),
          title: Row(
            children: [
              Icon(
                estActuellementPerdue
                    ? Icons.credit_card
                    : Icons.credit_card_off,
                color: estActuellementPerdue ? Colors.green : Colors.orange,
              ),
              SizedBox(width: ResponsiveUtils.wp(2)),
              Expanded(
                child: Text(
                  estActuellementPerdue
                      ? 'Carte retrouvée ?'
                      : 'Signaler carte perdue',
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(18),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          content: Text(
            estActuellementPerdue
                ? 'Confirmez-vous avoir retrouvé votre carte ? Elle sera réactivée.'
                : 'Confirmez-vous la perte de votre carte ? Elle sera désactivée pour votre sécurité.',
            style: TextStyle(fontSize: ResponsiveUtils.fontSize(14)),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Annuler',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                controller.signalerPerteCarte(!estActuellementPerdue);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor:
                    estActuellementPerdue ? Colors.green : Colors.orange,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                ),
              ),
              child: Text(
                'Confirmer',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // Méthode pour créer un bouton d'action
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Icône avec fond
          Container(
            padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: color.withValues(alpha: 0.3),
                  blurRadius: 8,
                  spreadRadius: 0,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Icon(
              icon,
              color: Colors.white,
              size: ResponsiveUtils.wp(5),
            ),
          ),
          // Espace entre l'icône et le texte
          SizedBox(height: ResponsiveUtils.hp(0.5)),
          // Texte du bouton
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: ResponsiveUtils.fontSize(12),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
