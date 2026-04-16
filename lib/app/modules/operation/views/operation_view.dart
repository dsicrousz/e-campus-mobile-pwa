import 'package:ecampusv2/app/modules/transaction/operation_model.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/operation_controller.dart';

class OperationView extends GetView<OperationController> {
  OperationView({super.key});
  final Operation o = Get.arguments;

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    // Détermination du type d'opération pour les styles
    final bool isRecharge = o.type == "RECHARGE";
    final bool isUtilisation = o.type == "UTILISATION";
    final bool isTransfert = o.type == "TRANSFERT";

    // Couleurs en fonction du type d'opération
    final Color primaryColor = isRecharge
        ? Colors.green
        : isUtilisation
            ? Colors.orange
            : isTransfert
                ? AppTheme.primaryColor
                : Colors.grey;

    final Color lightColor = isRecharge
        ? Colors.green.shade100
        : isUtilisation
            ? Colors.orange.shade100
            : isTransfert
                ? AppTheme.primaryColor.withValues(alpha: 0.15)
                : Colors.grey.shade100;

    // Icône en fonction du type d'opération
    final IconData operationIcon = isRecharge
        ? Icons.arrow_downward_rounded
        : isUtilisation
            ? Icons.shopping_cart_rounded
            : isTransfert
                ? Icons.swap_horiz_rounded
                : Icons.payments_rounded;

    return Scaffold(
      backgroundColor: Colors.white.withValues(alpha: 0.97),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_rounded,
            color: AppTheme.textPrimaryColor,
            size: ResponsiveUtils.wp(5),
          ),
          onPressed: () => Get.back(),
        ),
        title: Text(
          'Détails de la transaction',
          style: TextStyle(
            color: AppTheme.textPrimaryColor,
            fontSize: ResponsiveUtils.fontSize(18),
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(5),
              vertical: ResponsiveUtils.hp(2),
            ),
            child: Column(
              children: [
                // Carte principale de la transaction
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.symmetric(vertical: ResponsiveUtils.hp(2)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(6)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // En-tête avec icône et statut
                      Container(
                        padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [
                              primaryColor.withValues(alpha: 0.8),
                              primaryColor.withValues(alpha: 0.6),
                            ],
                          ),
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(ResponsiveUtils.wp(6)),
                            topRight: Radius.circular(ResponsiveUtils.wp(6)),
                          ),
                        ),
                        child: Row(
                          children: [
                            // Icône de transaction
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.3),
                                    blurRadius: 8,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                operationIcon,
                                color: primaryColor,
                                size: ResponsiveUtils.wp(8),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.wp(4)),
                            // Type et statut
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    isRecharge
                                        ? "Recharge"
                                        : isUtilisation
                                            ? "Utilisation"
                                            : isTransfert
                                                ? "Transfert"
                                                : "Autre opération",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: ResponsiveUtils.fontSize(18),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                                  Text(
                                    "Transaction réussie",
                                    style: TextStyle(
                                      color:
                                          Colors.white.withValues(alpha: 0.9),
                                      fontSize: ResponsiveUtils.fontSize(14),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Montant
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(4),
                                vertical: ResponsiveUtils.hp(1),
                              ),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(5)),
                              ),
                              child: Text(
                                "${o.montant ?? 0} FCFA",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ResponsiveUtils.fontSize(16),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Corps avec détails
                      Container(
                        padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Description
                            _buildDetailSection(
                              title: "Description",
                              content: o.description ?? 'Sans description',
                              icon: Icons.description_outlined,
                              color: primaryColor,
                            ),

                            Divider(height: ResponsiveUtils.hp(4)),

                            // Date et heure
                            _buildDetailSection(
                              title: "Date et heure",
                              content: o.createdAt != null
                                  ? "${DateFormat.yMd('fr_FR').format(DateTime.parse(o.createdAt!))} à ${DateFormat.Hms().format(DateTime.parse(o.createdAt!))}"
                                  : "Date inconnue",
                              icon: Icons.access_time_rounded,
                              color: primaryColor,
                            ),

                            // Code de la transaction
                            Divider(height: ResponsiveUtils.hp(4)),
                            _buildDetailSection(
                              title: "Date de création",
                              content: o.createdAt != null
                                  ? DateFormat('EEEE dd MMMM yyyy', 'fr_FR')
                                      .format(DateTime.parse(o.createdAt!))
                                  : "Date inconnue",
                              icon: Icons.calendar_today_rounded,
                              color: primaryColor,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),

                // Section récapitulative
                Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
                  padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                  decoration: BoxDecoration(
                    color: lightColor,
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Récapitulatif",
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: ResponsiveUtils.fontSize(16),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(2)),
                      _buildRecapItem(
                        label: "Montant",
                        value: "${o.montant ?? 0} FCFA",
                        color: primaryColor,
                      ),
                      Divider(height: ResponsiveUtils.hp(3)),
                      _buildRecapItem(
                        label: "Type",
                        value: isRecharge
                            ? "Recharge"
                            : isUtilisation
                                ? "Utilisation"
                                : isTransfert
                                    ? "Transfert"
                                    : "Autre",
                        color: primaryColor,
                      ),
                      Divider(height: ResponsiveUtils.hp(3)),
                      _buildRecapItem(
                        label: "Statut",
                        value: "Terminé",
                        color: Colors.green,
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

  // Widget pour une section de détail
  Widget _buildDetailSection({
    required String title,
    required String content,
    required IconData icon,
    required Color color,
  }) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: color,
            size: ResponsiveUtils.wp(5),
          ),
        ),
        SizedBox(width: ResponsiveUtils.wp(3)),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: ResponsiveUtils.fontSize(14),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(0.5)),
              Text(
                content,
                style: TextStyle(
                  color: AppTheme.textPrimaryColor,
                  fontSize: ResponsiveUtils.fontSize(16),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Widget pour un élément du récapitulatif
  Widget _buildRecapItem({
    required String label,
    required String value,
    required Color color,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade700,
            fontSize: ResponsiveUtils.fontSize(15),
          ),
        ),
        Text(
          value,
          style: TextStyle(
            color: color,
            fontSize: ResponsiveUtils.fontSize(15),
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
