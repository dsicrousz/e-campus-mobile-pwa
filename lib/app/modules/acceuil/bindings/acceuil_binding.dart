import 'package:ecampusv2/app/modules/acceuil/controllers/acceuil_controller.dart';
import 'package:get/get.dart';

class AcceuilBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AcceuilController>(
      () => AcceuilController(),
    );
  }
}
