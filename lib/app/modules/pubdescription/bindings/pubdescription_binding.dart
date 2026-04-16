import 'package:get/get.dart';

import '../controllers/pubdescription_controller.dart';

class PubdescriptionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<PubdescriptionController>(
      () => PubdescriptionController(),
    );
  }
}
