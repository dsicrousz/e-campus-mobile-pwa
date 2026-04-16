import 'package:get/get.dart';

import '../controllers/qrpage_controller.dart';

class QrpageBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrpageController>(
      () => QrpageController(),
    );
  }
}
