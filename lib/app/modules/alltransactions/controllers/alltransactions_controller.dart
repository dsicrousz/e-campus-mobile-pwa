import 'dart:convert';

import 'package:ecampusv2/app/modules/transaction/operation_model.dart';
import 'package:ecampusv2/app/modules/transaction/providers/operation_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class AlltransactionsController extends GetxController {
  OperationProvider operationProvider = OperationProvider();
  RxList<Operation?> operations = RxList<Operation>();
  GetStorage storage = GetStorage();
  final isLoading = false.obs;

  @override
  void onInit() {
    load();
    super.onInit();
  }

  void onQueryChange(String value) {
    if (value.isEmpty) {
      load();
    } else {
      operations.value = operations
          .where((element) => "${element!.description!}${element.montant}"
              .toLowerCase()
              .contains(value.toLowerCase()))
          .toList();
    }
  }

  void load() {
    isLoading(true);
    Compte currentCompte =
        Compte.fromJson(jsonDecode(storage.read('ecampus_compte')));
    String id = currentCompte.sId!;
    operationProvider.getOperations(id).then((value) {
      operations(value);
      isLoading(false);
    }, onError: (err) {
      Get.snackbar('Transactions Message', 'Une erreur s\' est produite',
          backgroundColor: Colors.red, colorText: Colors.white);
      isLoading(false);
    });
  }
}
