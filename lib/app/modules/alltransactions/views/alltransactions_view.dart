import 'package:ecampusv2/app/modules/transaction/operation_model.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import '../controllers/alltransactions_controller.dart';

class AlltransactionsView extends GetView<AlltransactionsController> {
  const AlltransactionsView({super.key});
  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

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
          'Mes Transactions',
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
      body: LiquidPullToRefresh(
        color: AppTheme.primaryColor,
        animSpeedFactor: 2.0,
        backgroundColor: Colors.white,
        borderWidth: 0,
        showChildOpacityTransition: true,
        height: ResponsiveUtils.hp(10),
        onRefresh: () async {
          controller.load();
        },
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(4),
            vertical: ResponsiveUtils.hp(2),
          ),
          child: Obx(
            () =>
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              // Barre de recherche moderne
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(2)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLg),
                  border: Border.all(color: AppTheme.borderColor, width: 1),
                  boxShadow: AppTheme.cardShadow,
                ),
                child: TextField(
                  onChanged: (value) => controller.onQueryChange(value),
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(14),
                    color: AppTheme.textPrimaryColor,
                  ),
                  decoration: InputDecoration(
                    hintText: "Rechercher une transaction",
                    hintStyle: TextStyle(
                      color: AppTheme.textSecondaryColor,
                      fontSize: ResponsiveUtils.fontSize(14),
                    ),
                    prefixIcon: Icon(
                      Icons.search,
                      color: AppTheme.primaryColor,
                      size: ResponsiveUtils.wp(5),
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: ResponsiveUtils.hp(1.5),
                      horizontal: ResponsiveUtils.wp(3),
                    ),
                  ),
                ),
              ),

              // Titre de section
              Container(
                margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1.5)),
                child: Text(
                  "Historique des transactions",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(16),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                  ),
                ),
              ),

              // Liste des transactions
              Expanded(
                child: controller.isLoading.value
                    ? Center(
                        child: SpinKitDoubleBounce(
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(15),
                        ),
                      )
                    : controller.operations.isEmpty
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.receipt_long,
                                  size: ResponsiveUtils.wp(20),
                                  color: Colors.grey.withValues(alpha: 0.5),
                                ),
                                SizedBox(height: ResponsiveUtils.hp(2)),
                                Text(
                                  "Aucune transaction trouvée",
                                  style: TextStyle(
                                    fontSize: ResponsiveUtils.fontSize(16),
                                    color: Colors.grey.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          )
                        : ListView.builder(
                            physics: const BouncingScrollPhysics(),
                            itemCount: controller.operations.length,
                            itemBuilder: (context, i) {
                              Operation? op = controller.operations[i];
                              if (op == null) return const SizedBox.shrink();
                              return Container(
                                margin: EdgeInsets.only(
                                    bottom: ResponsiveUtils.hp(1.5)),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radiusMd),
                                  border: Border.all(
                                      color: AppTheme.borderColor, width: 1),
                                  boxShadow: AppTheme.softShadow,
                                ),
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveUtils.wp(3)),
                                    onTap: () => Get.toNamed(Routes.OPERATION,
                                        arguments: op),
                                    child: Padding(
                                      padding:
                                          EdgeInsets.all(ResponsiveUtils.wp(3)),
                                      child: Row(
                                        children: [
                                          // Icône avec style moderne
                                          Container(
                                            width: ResponsiveUtils.wp(12),
                                            height: ResponsiveUtils.wp(12),
                                            decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              color: op.type == "RECHARGE"
                                                  ? AppTheme.successColor
                                                      .withValues(alpha: 0.8)
                                                  : op.type == "UTILISATION"
                                                      ? AppTheme.warningColor
                                                          .withValues(
                                                              alpha: 0.8)
                                                      : op.type == "TRANSFERT"
                                                          ? AppTheme
                                                              .primaryColor
                                                              .withValues(
                                                                  alpha: 0.8)
                                                          : AppTheme
                                                              .textSecondaryColor
                                                              .withValues(
                                                                  alpha: 0.8),
                                              boxShadow: [
                                                BoxShadow(
                                                  color: Colors.black
                                                      .withValues(alpha: 0.1),
                                                  blurRadius: 4,
                                                  spreadRadius: 0,
                                                  offset: const Offset(0, 2),
                                                ),
                                              ],
                                            ),
                                            child: Center(
                                              child: Icon(
                                                op.type == "RECHARGE"
                                                    ? Icons
                                                        .arrow_downward_rounded
                                                    : op.type == "UTILISATION"
                                                        ? Icons
                                                            .shopping_cart_rounded
                                                        : op.type == "TRANSFERT"
                                                            ? Icons
                                                                .swap_horiz_rounded
                                                            : Icons
                                                                .payments_rounded,
                                                color: Colors.white,
                                                size: ResponsiveUtils.wp(5),
                                              ),
                                            ),
                                          ),

                                          SizedBox(
                                              width: ResponsiveUtils.wp(3)),

                                          // Détails de la transaction
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  op.type == "RECHARGE"
                                                      ? "Recharge de ${op.montant ?? 0} FCFA"
                                                      : op.type == "UTILISATION"
                                                          ? "Utilisation de ${op.montant ?? 0} FCFA sur ${op.service?.nom ?? 'service'}"
                                                          : op.type ==
                                                                  "TRANSFERT"
                                                              ? "Transfert de ${op.montant ?? 0} FCFA"
                                                              : "Opération de ${op.montant ?? 0} FCFA",
                                                  style: TextStyle(
                                                    fontSize: ResponsiveUtils
                                                        .fontSize(15),
                                                    fontWeight: FontWeight.w600,
                                                    color: AppTheme
                                                        .textPrimaryColor,
                                                  ),
                                                ),
                                                SizedBox(
                                                    height: ResponsiveUtils.hp(
                                                        0.5)),
                                                Text(
                                                  op.createdAt != null
                                                      ? "${DateFormat.yMd('fr_FR').format(DateTime.parse(op.createdAt!))} à ${DateFormat.Hms().format(DateTime.parse(op.createdAt!))}"
                                                      : "Date inconnue",
                                                  style: TextStyle(
                                                    fontSize: ResponsiveUtils
                                                        .fontSize(12),
                                                    color: Colors.grey
                                                        .withValues(alpha: 0.8),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          // Montant avec style basé sur le type
                                          Container(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: ResponsiveUtils.wp(3),
                                              vertical: ResponsiveUtils.hp(0.8),
                                            ),
                                            decoration: BoxDecoration(
                                              color: (op.montant ?? 0) >= 0
                                                  ? AppTheme.successColor
                                                      .withValues(alpha: 0.1)
                                                  : AppTheme.errorColor
                                                      .withValues(alpha: 0.1),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      AppTheme.radiusMd),
                                            ),
                                            child: Text(
                                              "${op.montant ?? 0} F",
                                              style: TextStyle(
                                                fontSize:
                                                    ResponsiveUtils.fontSize(
                                                        14),
                                                fontWeight: FontWeight.w600,
                                                color: (op.montant ?? 0) >= 0
                                                    ? AppTheme.successColor
                                                    : AppTheme.errorColor,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
