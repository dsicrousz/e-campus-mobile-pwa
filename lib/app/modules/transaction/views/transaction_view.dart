import 'package:ecampusv2/app/modules/transaction/operation_model.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:getwidget/getwidget.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import '../controllers/transaction_controller.dart';

class TransactionView extends GetView<TransactionController> {
  const TransactionView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    // Utilisation de LayoutBuilder pour récupérer la hauteur disponible
    // et garantir que les états (loading/empty/error) s'adaptent sans overflow
    return LayoutBuilder(
      builder: (context, constraints) {
        return LiquidPullToRefresh(
          color: AppTheme.primaryColor.withValues(alpha: 0.8),
          backgroundColor: Colors.white,
          height: ResponsiveUtils.hp(5),
          animSpeedFactor: 2,
          showChildOpacityTransition: false,
          onRefresh: () async {
            return controller.load();
          },
          child: controller.obx(
            (state) => ListView.builder(
              physics: const BouncingScrollPhysics(),
              padding: EdgeInsets.symmetric(
                horizontal: ResponsiveUtils.wp(4),
                vertical: ResponsiveUtils.hp(2),
              ),
              itemCount: state!.length,
              itemBuilder: (context, i) {
                Operation? op = state[i];
                if (op == null) return const SizedBox.shrink();

                // Détermination du type d'opération pour les styles
                final bool isRecharge = op.type == "RECHARGE";
                final bool isUtilisation = op.type == "UTILISATION";
                final bool isTransfert = op.type == "TRANSFERT";

                // Couleurs en fonction du type d'opération
                final Color primaryColor = isRecharge
                    ? Colors.green
                    : isUtilisation
                        ? Colors.orange
                        : isTransfert
                            ? AppTheme.primaryColor
                            : Colors.grey;

                // Icône en fonction du type d'opération
                final IconData operationIcon = isRecharge
                    ? Icons.arrow_downward_rounded
                    : isUtilisation
                        ? Icons.shopping_cart_rounded
                        : isTransfert
                            ? Icons.swap_horiz_rounded
                            : Icons.payments_rounded;

                return Container(
                  margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(1.5)),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 8,
                        spreadRadius: 0,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(3)),
                      onTap: () => Get.toNamed(Routes.OPERATION, arguments: op),
                      splashColor: primaryColor.withValues(alpha: 0.1),
                      highlightColor: primaryColor.withValues(alpha: 0.05),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: ResponsiveUtils.wp(3),
                          vertical: ResponsiveUtils.hp(1.2),
                        ),
                        child: Row(
                          children: [
                            // Icône de transaction
                            Container(
                              padding: EdgeInsets.all(ResponsiveUtils.wp(2.5)),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: [
                                    primaryColor,
                                    primaryColor.withValues(alpha: 0.7),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withValues(alpha: 0.3),
                                    blurRadius: 4,
                                    spreadRadius: 0,
                                    offset: const Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: Icon(
                                operationIcon,
                                color: Colors.white,
                                size: ResponsiveUtils.wp(5),
                              ),
                            ),
                            SizedBox(width: ResponsiveUtils.wp(3)),

                            // Description et date
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    op.type == "RECHARGE"
                                        ? "Recharge de ${op.montant ?? 0} FCFA"
                                        : op.type == "UTILISATION"
                                            ? "Utilisation de ${op.montant ?? 0} FCFA sur ${op.service?.nom ?? 'service'}"
                                            : op.type == "TRANSFERT"
                                                ? "Transfert de ${op.montant ?? 0} FCFA"
                                                : "Opération de ${op.montant ?? 0} FCFA",
                                    style: TextStyle(
                                      color: AppTheme.textPrimaryColor,
                                      fontSize: ResponsiveUtils.fontSize(15),
                                      fontWeight: FontWeight.w600,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  SizedBox(height: ResponsiveUtils.hp(0.5)),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.access_time_rounded,
                                        color: Colors.grey.shade400,
                                        size: ResponsiveUtils.wp(3.5),
                                      ),
                                      SizedBox(width: ResponsiveUtils.wp(1)),
                                      Text(
                                        op.createdAt != null
                                            ? "${DateFormat.yMd('fr_FR').format(DateTime.parse(op.createdAt!))} à ${DateFormat.Hm('fr_FR').format(DateTime.parse(op.createdAt!))}"
                                            : "Date inconnue",
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize:
                                              ResponsiveUtils.fontSize(12),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),

                            // Montant
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: ResponsiveUtils.wp(3),
                                vertical: ResponsiveUtils.hp(0.8),
                              ),
                              decoration: BoxDecoration(
                                color: primaryColor.withValues(alpha: 0.1),
                                borderRadius: BorderRadius.circular(
                                    ResponsiveUtils.wp(3)),
                              ),
                              child: Text(
                                "${op.montant ?? 0} FCFA",
                                style: TextStyle(
                                  color: primaryColor,
                                  fontSize: ResponsiveUtils.fontSize(13),
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),

            // État quand la liste est vide
            onEmpty: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ResponsiveUtils.wp(50),
                        height: ResponsiveUtils.wp(50),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Image(
                          image: AssetImage("assets/empty.png"),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(2)),
                      Text(
                        "Aucune transaction pour le moment",
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: ResponsiveUtils.fontSize(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(1)),
                      Text(
                        "Tirez vers le bas pour rafraîchir",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: ResponsiveUtils.fontSize(14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // État de chargement
            onLoading: SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GFLoader(
                        type: GFLoaderType.custom,
                        child: SpinKitDoubleBounce(
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(15),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(2)),
                      Text(
                        "Chargement des transactions...",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: ResponsiveUtils.fontSize(14),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // État d'erreur
            onError: (err) => SingleChildScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              child: SizedBox(
                height: constraints.maxHeight,
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: ResponsiveUtils.wp(50),
                        height: ResponsiveUtils.wp(50),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade100,
                          shape: BoxShape.circle,
                        ),
                        child: const Image(
                          image: AssetImage("assets/empty.png"),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(2)),
                      Text(
                        "Aucune transaction trouvée",
                        style: TextStyle(
                          color: AppTheme.textPrimaryColor,
                          fontSize: ResponsiveUtils.fontSize(16),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(1)),
                      Text(
                        "Appuyez pour réessayer",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: ResponsiveUtils.fontSize(14),
                        ),
                      ),
                      SizedBox(height: ResponsiveUtils.hp(2)),
                      ElevatedButton(
                        onPressed: () => controller.load(),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal: ResponsiveUtils.wp(6),
                            vertical: ResponsiveUtils.hp(1.2),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.wp(5)),
                          ),
                        ),
                        child: Text(
                          "Actualiser",
                          style: TextStyle(
                            fontSize: ResponsiveUtils.fontSize(14),
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
