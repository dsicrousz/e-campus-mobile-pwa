import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class SplashController extends GetxController {
  GetStorage storage = GetStorage();

  @override
  void onReady() {
    super.onReady();

    var isIntro = storage.read('isIntro');
    var token = storage.read('ecampus_compte');
    if (isIntro != null) {
      Future.delayed(const Duration(milliseconds: 2000), () {
        if (token != null) {
          Get.offAndToNamed(Routes.HOME);
        } else {
          Get.offAndToNamed(Routes.LOGIN);
        }
      });
    } else {
      Future.delayed(const Duration(milliseconds: 2000), () {
        Get.offAndToNamed(Routes.INTRODUCTION);
      });
    }
  }
}
