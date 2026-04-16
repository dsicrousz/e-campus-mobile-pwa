import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_fonts/google_fonts.dart';

class ThemeController extends GetxController {
  final box = GetStorage();

  RxBool isDarkMode = false.obs;

  @override
  void onInit() {
    super.onInit();
    isDarkMode.value = box.read('isDarkMode') ?? false;
  }

  void toggleTheme() {
    isDarkMode.value = !isDarkMode.value;
    Get.changeTheme(
      isDarkMode.value
          ? FlexThemeData.dark(
              scheme: FlexScheme.flutterDash,
              textTheme: GoogleFonts.robotoTextTheme())
          : FlexThemeData.light(
              scheme: FlexScheme.flutterDash,
              textTheme: GoogleFonts.robotoTextTheme()),
    );
    box.write('isDarkMode', isDarkMode.value);
  }

  @override
  void onClose() {
    super.onClose();
    isDarkMode.close();
  }
}
