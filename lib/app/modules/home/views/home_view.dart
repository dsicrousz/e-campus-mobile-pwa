import 'package:ecampusv2/app/modules/drawerPage/views/drawer_page_view.dart';
import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final storage = GetStorage();
    final hasCompletedProfile = storage.read('hasCompletedProfile') ?? false;

    if (!hasCompletedProfile) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Get.offAllNamed(Routes.COMPLETE_PROFILE);
      });
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return const DrawerPageView();
  }
}
