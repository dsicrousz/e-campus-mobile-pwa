import 'package:ecampusv2/app/modules/acceuil/views/acceuil_view.dart';
import 'package:ecampusv2/app/modules/drawerPage/views/menu_screen_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import 'package:get/get.dart';

import '../controllers/drawer_page_controller.dart';

class DrawerPageView extends GetView<DrawerPageController> {
  const DrawerPageView({super.key});
  @override
  Widget build(BuildContext context) {
    return GetBuilder<DrawerPageController>(
      builder: (controller) => ZoomDrawer(
        controller: controller.zoomDrawerController,
        menuScreen: const MenuScreenView(),
        mainScreen: AcceuilView(),
        borderRadius: 24.0,
        showShadow: true,
        menuBackgroundColor: const Color.fromARGB(255, 201, 234, 248),
        angle: -8.0,
        drawerShadowsBackgroundColor: Colors.grey,
        slideWidth: MediaQuery.of(context).size.width * 0.80,
      ),
    );
  }
}
