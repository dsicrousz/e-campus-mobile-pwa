import 'dart:convert';

import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:ecampusv2/app/modules/acceuil/controllers/acceuil_controller.dart';
import 'package:ecampusv2/app/modules/passwordUpdate/controllers/password_update_controller.dart';
import 'package:ecampusv2/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class DrawerPageController extends GetxController {
  final zoomDrawerController = ZoomDrawerController();
  Compte currentCompte = Compte();
  GetStorage storage = GetStorage();

  DrawerPageController() {
    currentCompte = Compte.fromJson(jsonDecode(storage.read('ecampus_compte')));
    update();
  }

  void toggleDrawer() {
    zoomDrawerController.toggle?.call();
  }

  void logout() async {
    Get.delete<AcceuilController>();
    Get.delete<DrawerPageController>();
    Get.delete<TransactionController>();
    Get.delete<PasswordUpdateController>();
    await storage.remove('ecampus_compte');
    Get.offAndToNamed(Routes.LOGIN);
  }
}
