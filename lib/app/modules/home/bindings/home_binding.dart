import 'package:ecampusv2/app/modules/acceuil/controllers/acceuil_controller.dart';
import 'package:ecampusv2/app/modules/assistance/controllers/assistance_controller.dart';
import 'package:ecampusv2/app/modules/drawerPage/controllers/drawer_page_controller.dart';
import 'package:ecampusv2/app/modules/pub/controllers/pub_controller.dart';
import 'package:ecampusv2/app/modules/transaction/controllers/transaction_controller.dart';
import 'package:get/get.dart';

import '../controllers/home_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
      () => HomeController(),
    );
    Get.lazyPut<AcceuilController>(
      () => AcceuilController(),
    );

    Get.lazyPut<TransactionController>(
      () => TransactionController(),
    );

    Get.lazyPut<DrawerPageController>(
      () => DrawerPageController(),
    );

    Get.lazyPut<AssistanceController>(
      () => AssistanceController(),
    );
    Get.lazyPut<PubController>(
      () => PubController(),
    );
  }
}
