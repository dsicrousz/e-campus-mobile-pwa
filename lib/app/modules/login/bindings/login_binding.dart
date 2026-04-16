import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:get/get.dart';

import '../controllers/login_controller.dart';

class LoginBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
    Get.lazyPut<CompteProvider>(
      () => CompteProvider(),
    );
  }
}
