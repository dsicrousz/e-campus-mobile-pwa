import 'dart:convert';

import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/modules/acceuil/controllers/acceuil_controller.dart';
import 'package:ecampusv2/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:ecampusv2/app/modules/transaction/providers/operation_provider.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:pinput/pinput.dart';

class VirementController extends GetxController {
  final ncs = ''.obs;
  final montant = 0.obs;
  final isLoading = false.obs;
  OperationProvider operationProvider = OperationProvider();
  CompteProvider compteProvider = CompteProvider();
  GetStorage storage = GetStorage();
  
  // Utilisation de getters lazy pour éviter l'erreur d'initialisation
  TransactionController get transactionController =>
      Get.find<TransactionController>();
  AcceuilController get acceuilController => Get.find<AcceuilController>();

  // Validation du formulaire
  bool get isFormValid {
    return ncs.value.isNotEmpty && 
           montant.value > 0 && 
           montant.value <= (acceuilController.compte.solde ?? 0);
  }

  // Message d'erreur pour le solde insuffisant
  bool get isSoldeInsuffisant {
    return montant.value > 0 && 
           montant.value > (acceuilController.compte.solde ?? 0);
  }

  void send() async {
    // Initialisation responsive
    ResponsiveUtils.init(Get.context!);
    
    final defaultPinTheme = PinTheme(
      width: ResponsiveUtils.wp(12),
      height: ResponsiveUtils.wp(12),
      textStyle: TextStyle(
        fontSize: ResponsiveUtils.fontSize(18),
        color: AppTheme.textPrimaryColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: AppTheme.primaryColor.withValues(alpha: 0.3),
          width: 1.5,
        ),
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(
        color: AppTheme.primaryColor,
        width: 2,
      ),
      borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
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
      ),
    );
    Compte currentCompte =
        Compte.fromJson(jsonDecode(storage.read('ecampus_compte')));
    String id = currentCompte.sId!;
    String? pass = await Get.bottomSheet(
      Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(ResponsiveUtils.wp(8)),
            topRight: Radius.circular(ResponsiveUtils.wp(8)),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 20,
              spreadRadius: 0,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(
          horizontal: ResponsiveUtils.wp(6),
          vertical: ResponsiveUtils.hp(3),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Indicateur de drag moderne
              Container(
                width: ResponsiveUtils.wp(15),
                height: ResponsiveUtils.hp(0.7),
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(1)),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(3)),

              // Icône de verrouillage avec gradient
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppTheme.primaryColor.withValues(alpha: 0.1),
                      AppTheme.secondaryColor.withValues(alpha: 0.1),
                    ],
                  ),
                  shape: BoxShape.circle,
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Icon(
                  Icons.lock_rounded,
                  color: AppTheme.primaryColor,
                  size: ResponsiveUtils.wp(10),
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(2)),

              // Titre moderne
              Text(
                "Code de sécurité",
                style: TextStyle(
                  fontSize: ResponsiveUtils.fontSize(22),
                  fontWeight: FontWeight.bold,
                  color: AppTheme.textPrimaryColor,
                ),
              ),
              SizedBox(height: ResponsiveUtils.hp(1)),

              // Sous-titre avec icône
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.shield_outlined,
                    color: AppTheme.secondaryColor,
                    size: ResponsiveUtils.wp(4),
                  ),
                  SizedBox(width: ResponsiveUtils.wp(2)),
                  Flexible(
                    child: Text(
                      "Saisissez votre code à 6 chiffres",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(14),
                        color: AppTheme.textSecondaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: ResponsiveUtils.hp(3)),

              // Champ de saisie du code PIN
              Pinput(
                length: 6,
                autofocus: true,
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                keyboardType: TextInputType.number,
                obscureText: true,
                obscuringCharacter: "●",
                onCompleted: (pin) {
                  Get.back(result: pin);
                },
                pinAnimationType: PinAnimationType.fade,
              ),

              SizedBox(height: ResponsiveUtils.hp(3)),

              // Message de sécurité
              Container(
                padding: EdgeInsets.all(ResponsiveUtils.wp(3)),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.05),
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                  border: Border.all(
                    color: Colors.green.withValues(alpha: 0.2),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.verified_user_rounded,
                      color: Colors.green,
                      size: ResponsiveUtils.wp(5),
                    ),
                    SizedBox(width: ResponsiveUtils.wp(2)),
                    Expanded(
                      child: Text(
                        "Transaction sécurisée et cryptée",
                        style: TextStyle(
                          fontSize: ResponsiveUtils.fontSize(12),
                          color: Colors.green.shade700,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: ResponsiveUtils.hp(3)),

              // Bouton d'annulation moderne
              InkWell(
                onTap: () => Get.back(),
                borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(
                    vertical: ResponsiveUtils.hp(1.5),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.grey.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(ResponsiveUtils.wp(2)),
                    border: Border.all(
                      color: Colors.grey.withValues(alpha: 0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "ANNULER",
                      style: TextStyle(
                        fontSize: ResponsiveUtils.fontSize(14),
                        fontWeight: FontWeight.bold,
                        color: AppTheme.textSecondaryColor,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: ResponsiveUtils.hp(2)),
            ],
          ),
        ),
      ),
      isDismissible: false,
      enableDrag: true,
    );
    if (pass != null) {
      isLoading(true);
      try {
        await compteProvider.passMath(id, pass);
      } catch (e) {
        Get.snackbar('Virement Message', 'Mot de passe incorrect !!',
            backgroundColor: Colors.red, colorText: Colors.white);
        isLoading(false);
        return;
      }

      if (ncs.isEmpty || montant.value.isLowerThan(50)) {
        Get.snackbar('Virement Message',
            'Le montant doit être supérieur à 50 !! \n et le numero doit être valide !',
            backgroundColor: Colors.red, colorText: Colors.white);
        return;
      }
      compteProvider.getCompteByNcs(ncs.value).then((res) {
        operationProvider.virement(id, res!.sId!, montant.value).then((res) {
          Get.back();
          Get.snackbar(
              'Virement Message', 'Le virement a été éffectué avec success !!',
              backgroundColor: Colors.green, colorText: Colors.white);
          isLoading(false);
          transactionController.load();
          acceuilController.load();
        }, onError: (err) {
          isLoading(false);
          Get.snackbar('Virement Message', 'Le virement a échoué !!',
              backgroundColor: Colors.red, colorText: Colors.white);
        });
      }, onError: (err) {
        isLoading(false);
        Get.snackbar('Compte Message', 'Compte non trouvé!!!',
            backgroundColor: Colors.red, colorText: Colors.white);
      });
    }
  }

  @override
  void onClose() {
    super.onClose();
    ncs.close();
    montant.close();
    isLoading.close();
  }
}
