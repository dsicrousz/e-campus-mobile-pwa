import 'package:get/get.dart';

import '../controllers/pub_controller.dart';

class PubBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PubController>(
      () => PubController(),
    );
  }
}
