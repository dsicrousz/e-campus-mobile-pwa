import 'package:get/get.dart';

import '../controllers/allpubs_controller.dart';

class AllpubsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AllpubsController>(
      () => AllpubsController(),
    );
  }
}
