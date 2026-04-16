import 'dart:convert';
import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/modules/validations.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

enum LoginAuthMode { qrCode, ncs }

class LoginController extends GetxController with Validations {
  final authMode = LoginAuthMode.qrCode.obs;
  final code = ''.obs;
  final ncs = ''.obs;
  final password = ''.obs;
  final isLoading = false.obs;
  CompteProvider compteProvider = CompteProvider();
  GetStorage storage = GetStorage();

  void setAuthMode(LoginAuthMode mode) {
    authMode(mode);
  }

  void login() {
    isLoading(true);
    compteProvider.getCompte(code.value, password.value).then((res) async {
      if (res?.isactif == false) {
        Get.snackbar('Login Message', "Votre compte est déactivé !! ",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        await storage.write('ecampus_compte', jsonEncode(res));
        Get.offAndToNamed(Routes.HOME);
      }
      isLoading(false);
    }, onError: (err) {
      isLoading(false);
      Get.snackbar('Login Message', 'La connexion a échouée',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  void loginWithNcs() {
    isLoading(true);
    compteProvider.getCompteWithNcs(ncs.value, password.value).then(
        (res) async {
      if (res?.isactif == false) {
        Get.snackbar('Login Message', "Votre compte est déactivé !! ",
            backgroundColor: Colors.red, colorText: Colors.white);
      } else {
        await storage.write('ecampus_compte', jsonEncode(res));
        Get.offAndToNamed(Routes.HOME);
      }
      isLoading(false);
    }, onError: (err) {
      isLoading(false);
      Get.snackbar('Login Message', 'La connexion a échouée',
          backgroundColor: Colors.red, colorText: Colors.white);
    });
  }

  @override
  void onClose() {
    super.onClose();
    authMode.close();
    code.close();
    ncs.close();
    password.close();
    isLoading.close();
  }
}
