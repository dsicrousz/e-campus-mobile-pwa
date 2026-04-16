import 'dart:convert';
import 'package:ecampusv2/app/data/models/compte_model.dart';
import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/modules/drawerPage/controllers/drawer_page_controller.dart';
import 'package:ecampusv2/app/modules/pub/controllers/pub_controller.dart';
import 'package:ecampusv2/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:ecampusv2/env.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:socket_io_client/socket_io_client.dart';

class AcceuilController extends GetxController {
  GetStorage storage = GetStorage();
  Compte compte = Compte();
  CompteProvider compteProvider = CompteProvider();
  final isSoldeShow = false.obs;
  final isCartePerdue = false.obs;
  final TransactionController transactionController =
      Get.put(TransactionController());
  final PubController pubController = Get.find();
  final DrawerPageController drawerPageController =
      Get.put(DrawerPageController());

  @override
  void onInit() {
    final storedCompte = storage.read('ecampus_compte');
    if (storedCompte != null) {
      compte = Compte.fromJson(jsonDecode(storedCompte));
      isCartePerdue.value = compte.est_perdu ?? false;
    }
    if (compte.sId != null) {
      Socket socket = io(
          backUrl,
          OptionBuilder()
              .setTransports(['websocket'])
              .disableAutoConnect()
              .build());
      socket.onConnect((_) {
        socket.emit('sign', {"compteId": compte.sId});
      });
      socket.on('update', (data) => load());
      socket.connect();
      load();
    }
    super.onInit();
  }

  @override
  void onClose() {
    super.onClose();
    isSoldeShow.close();
    pubController.dispose();
    transactionController.dispose();
    drawerPageController.dispose();
  }

  Future<void> load() async {
    if (compte.sId == null) return;
    await compteProvider.load(compte.sId!).then((value) {
      if (value != null) {
        compte = value;
        isCartePerdue.value = compte.est_perdu ?? false;
      }
    },
        onError: (err) => Get.snackbar(
            'Compte status', 'Error lors du rafraichissement !',
            colorText: Colors.white, backgroundColor: Colors.red));
    transactionController.load();
    pubController.load();
  }

  void hideSolde() {
    isSoldeShow(false);
    load();
  }

  void showSolde() {
    load();
    isSoldeShow(true);
  }

  Future<void> signalerPerteCarte(bool estPerdu) async {
    if (compte.sId == null) return;
    try {
      await compteProvider.signalerPerteCarte(compte.sId!, estPerdu);
      compte.est_perdu = estPerdu;
      isCartePerdue.value = estPerdu;
      await load();
      Get.snackbar(
        'Carte',
        estPerdu
            ? 'Carte signalée comme perdue'
            : 'Carte signalée comme retrouvée',
        colorText: Colors.white,
        backgroundColor: estPerdu ? Colors.orange : Colors.green,
      );
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Impossible de mettre à jour le statut de la carte',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    }
  }
}
