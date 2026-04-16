import 'package:get/get.dart';

import '../controllers/virement_controller.dart';
import '../../transaction/controllers/transaction_controller.dart';

class VirementBinding extends Bindings {
  @override
  void dependencies() {
    // Enregistrer TransactionController s'il n'existe pas déjà
    if (!Get.isRegistered<TransactionController>()) {
      Get.lazyPut<TransactionController>(
        () => TransactionController(),
      );
    }
    
    Get.lazyPut<VirementController>(
      () => VirementController(),
    );
  }
}
