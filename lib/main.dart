import 'package:ecampusv2/app/data/providers/compte_provider.dart';
import 'package:ecampusv2/app/modules/transaction/providers/operation_provider.dart';
import 'package:ecampusv2/app/utils/app_theme.dart';
import 'package:ecampusv2/app/utils/responsive_wrapper.dart';
import 'package:ecampusv2/utils/themecontroller.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:get_storage/get_storage.dart';

import 'app/routes/app_pages.dart';

void main() async {
  await GetStorage.init();
  await initializeDateFormatting('fr_FR', null);
  Get.put<CompteProvider>(CompteProvider());
  Get.put<OperationProvider>(OperationProvider());
  Get.put<ThemeController>(ThemeController());
  // Set preferred orientations for the app
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  runApp(
    GetMaterialApp(
      title: "E-CAMPUS",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        colorScheme: const ColorScheme.light(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.secondaryColor,
          tertiary: AppTheme.accentColor,
          surface: AppTheme.cardColor,
        ),
        scaffoldBackgroundColor: AppTheme.backgroundColor,
        cardColor: AppTheme.cardColor,
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.textLightColor),
          titleTextStyle: TextStyle(
              color: AppTheme.textLightColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        textTheme: GoogleFonts.poppinsTextTheme(),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.secondaryColor,
            foregroundColor: AppTheme.textLightColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
      ),
      darkTheme: ThemeData(
        primaryColor: AppTheme.primaryColor,
        colorScheme: const ColorScheme.dark(
          primary: AppTheme.primaryColor,
          secondary: AppTheme.secondaryColor,
          tertiary: AppTheme.accentColor,
          surface: Color(0xFF424242),
        ),
        scaffoldBackgroundColor: AppTheme.darkBackgroundColor,
        cardColor: const Color(0xFF424242),
        appBarTheme: const AppBarTheme(
          backgroundColor: AppTheme.primaryColor,
          elevation: 0,
          iconTheme: IconThemeData(color: AppTheme.textLightColor),
          titleTextStyle: TextStyle(
              color: AppTheme.textLightColor,
              fontSize: 20,
              fontWeight: FontWeight.bold),
        ),
        textTheme: GoogleFonts.poppinsTextTheme()
            .apply(bodyColor: AppTheme.textLightColor),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppTheme.secondaryColor,
            foregroundColor: AppTheme.textLightColor,
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 2,
          ),
        ),
      ),
      themeMode: Get.find<ThemeController>().isDarkMode.value
          ? ThemeMode.dark
          : ThemeMode.light,
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      builder: (context, child) {
        // Apply responsive wrapper to all screens
        return ResponsiveWrapper(
          child: child!,
        );
      },
    ),
  );
}
