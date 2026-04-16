import 'package:ecampusv2/app/data/models/pub_model.dart';
import 'package:ecampusv2/app/data/providers/pub_provider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AllpubsController extends GetxController {
  final PubProvider pubProvider = PubProvider();
  final RxList<Pub> allPubs = <Pub>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadAllPubs();
  }

  // Charger toutes les annonces
  Future<void> loadAllPubs() async {
    try {
      isLoading(true);
      hasError(false);
      errorMessage('');
      
      final result = await pubProvider.load();
      // Conversion des Pub? en Pub en filtrant les valeurs null
      final nonNullPubs = result.where((p) => p != null).cast<Pub>().toList();
      allPubs.assignAll(nonNullPubs);
    } catch (e) {
      hasError(true);
      errorMessage('Impossible de charger les annonces: ${e.toString()}');
      Get.snackbar(
        'Erreur',
        'Impossible de charger les annonces',
        backgroundColor: Colors.red,
        colorText: Colors.white,
        snackPosition: SnackPosition.BOTTOM,
      );
    } finally {
      isLoading(false);
    }
  }

  // Filtrer les annonces selon la recherche
  List<Pub> get filteredPubs {
    if (searchQuery.value.isEmpty) {
      return allPubs;
    }
    
    return allPubs.where((pub) => 
      pub.titre?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true ||
      pub.description?.toLowerCase().contains(searchQuery.value.toLowerCase()) == true
    ).toList();
  }

  // Mettre à jour la requête de recherche
  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }
}
