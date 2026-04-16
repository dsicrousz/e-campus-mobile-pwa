import 'dart:convert';

import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/modules/acceuil/controllers/acceuil_controller.dart';
import 'package:ecampusv2/app/modules/drawerPage/controllers/drawer_page_controller.dart';
import 'package:ecampusv2/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PasswordUpdateController extends GetxController {
  final oldPass = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  Compte compte = Compte();
  CompteProvider compteProvider = CompteProvider();
  GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();
    compte = Compte.fromJson(jsonDecode(storage.read('ecampus_compte')));
  }

  void changePassword() {
    if ((oldPass.value.length < 6) || (password.value.length < 6)) {
      Get.snackbar(
          'Modification Code Secret', "Veuillez remplir tous les champs !",
          backgroundColor: Colors.red, colorText: Colors.white);
      return;
    }
    isLoading(true);
    compteProvider
        .changePassword(compte.sId!, oldPass.value, password.value)
        .then((value) {
      isLoading(false);
      Get.snackbar('Modification Code Secret',
          "Le Code Secret a été changé avec success !",
          backgroundColor: Colors.green, colorText: Colors.white);
      oldPass('');
      password('');
      logout();
    }, onError: (err) {
      isLoading(false);
      Get.snackbar('Modification Code Secret', "Echec de la modification !",
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  void logout() async {
    Get.delete<AcceuilController>();
    Get.delete<DrawerPageController>();
    Get.delete<TransactionController>();
    Get.delete<PasswordUpdateController>();
    await storage.remove('ecampus_compte');
    Get.offAndToNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    super.onClose();
    oldPass.close();
    password.close();
  }
}
