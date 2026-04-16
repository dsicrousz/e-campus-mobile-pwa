import 'package:get/get.dart';

import '../controllers/operation_controller.dart';

class OperationBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<OperationController>(
      () => OperationController(),
    );
  }
}
