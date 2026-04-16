import 'package:get/get.dart';

import '../controllers/alltransactions_controller.dart';

class AlltransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AlltransactionsController>(
      () => AlltransactionsController(),
    );
  }
}
