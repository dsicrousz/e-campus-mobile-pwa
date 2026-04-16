import 'dart:convert';

import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class QrpageController extends GetxController {
  GetStorage storage = GetStorage();
  Compte compte = Compte();

  @override
  void onInit() {
    super.onInit();
    final raw = storage.read('ecampus_compte');
    if (raw != null) {
      try {
        compte = Compte.fromJson(jsonDecode(raw));
      } catch (_) {}
    }
  }
}
