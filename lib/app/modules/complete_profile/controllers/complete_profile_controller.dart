import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'dart:convert';

class CompleteProfileController extends GetxController {
  final storage = GetStorage();
  final compteProvider = CompteProvider();

  final isLoading = false.obs;
  final currentStep = 0.obs;

  // Informations personnelles
  final telSecondaire = ''.obs;

  // Loisirs
  final hobbies = <String>[].obs;
  final hobbyInput = ''.obs;

  // Conditions
  final accepteConditions = false.obs;

  String? get etudiantId {
    final compteData = storage.read('ecampus_compte');
    if (compteData != null) {
      final compte = jsonDecode(compteData);
      return compte['etudiant']?['_id'];
    }
    return null;
  }

  void nextStep() {
    if (currentStep.value < 2) {
      currentStep.value++;
    }
  }

  void previousStep() {
    if (currentStep.value > 0) {
      currentStep.value--;
    }
  }

  void addHobby() {
    if (hobbyInput.value.isNotEmpty) {
      hobbies.add(hobbyInput.value);
      hobbyInput.value = '';
    }
  }

  void removeHobby(int index) {
    hobbies.removeAt(index);
  }

  Future<void> completeProfile() async {
    if (!accepteConditions.value) {
      Get.snackbar(
        'Erreur',
        'Veuillez accepter les conditions d\'utilisation',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    final id = etudiantId;
    if (id == null) {
      Get.snackbar(
        'Erreur',
        'Impossible de récupérer les informations de l\'étudiant',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
      return;
    }

    isLoading(true);
    try {
      final data = <String, dynamic>{
        if (telSecondaire.value.isNotEmpty)
          'telSecondaire': telSecondaire.value,
        if (hobbies.isNotEmpty) 'hobbies': hobbies.toList(),
        'accepteConditions': accepteConditions.value,
      };

      await compteProvider.completeProfile(id, data);
      storage.write('hasCompletedProfile', true);

      Get.snackbar(
        'Succès',
        'Profil complété avec succès',
        colorText: Colors.white,
        backgroundColor: Colors.green,
      );

      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      Get.snackbar(
        'Erreur',
        'Une erreur est survenue lors de la mise à jour du profil',
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } finally {
      isLoading(false);
    }
  }
}
