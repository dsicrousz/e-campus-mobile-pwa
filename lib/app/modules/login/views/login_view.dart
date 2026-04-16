import 'package:ai_barcode_scanner/ai_barcode_scanner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import '../../../utils/app_theme.dart';
import '../../../utils/responsive_utils.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    // Initialize responsive utilities
    ResponsiveUtils.init(context);

    final defaultPinTheme = PinTheme(
      width: ResponsiveUtils.wp(6), // Responsive width
      height: ResponsiveUtils.hp(6), // Responsive height
      textStyle: TextStyle(
          fontSize: ResponsiveUtils.fontSize(20),
          color: AppTheme.textPrimaryColor,
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppTheme.primaryColor.withValues(alpha: 0.3)),
        borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: AppTheme.secondaryColor, width: 2),
      borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
      boxShadow: [
        BoxShadow(
          color: AppTheme.secondaryColor.withValues(alpha: 0.2),
          blurRadius: 8,
          offset: const Offset(0, 3),
        ),
      ],
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: AppTheme.primaryColor.withValues(alpha: 0.1),
        border: Border.all(color: AppTheme.primaryColor),
      ),
    );
    return Scaffold(
        body: Container(
      color: AppTheme.backgroundColor,
      child: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            constraints: BoxConstraints(
              minHeight: ResponsiveUtils.screenHeight - ResponsiveUtils.hp(10),
            ),
            padding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(6)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Indicateur de chargement moderne
                Obx(() => controller.isLoading.value
                    ? Container(
                        margin: EdgeInsets.only(bottom: ResponsiveUtils.hp(3)),
                        padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppTheme.primaryColor.withValues(alpha: 0.2),
                              blurRadius: 20,
                              spreadRadius: 2,
                              offset: const Offset(0, 5),
                            ),
                          ],
                        ),
                        child: SpinKitRing(
                          color: AppTheme.primaryColor,
                          size: ResponsiveUtils.wp(15),
                          lineWidth: 4,
                        ),
                      )
                    : const SizedBox.shrink()),

                // Logo avec animation
                TweenAnimationBuilder(
                  duration: const Duration(milliseconds: 800),
                  tween: Tween<double>(begin: 0, end: 1),
                  builder: (context, double value, child) {
                    return Transform.scale(
                      scale: value,
                      child: Opacity(
                        opacity: value,
                        child: child,
                      ),
                    );
                  },
                  child: Container(
                    padding: EdgeInsets.all(ResponsiveUtils.wp(6)),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius:
                          BorderRadius.circular(ResponsiveUtils.wp(6)),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.08),
                          blurRadius: 20,
                          spreadRadius: 0,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Image(
                      image: const AssetImage("assets/logo2.jpeg"),
                      width: ResponsiveUtils.wp(50),
                    ),
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(2)),

                // Titre de bienvenue
                Text(
                  "Bienvenue sur E-Campus",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(26),
                    fontWeight: FontWeight.bold,
                    color: AppTheme.textPrimaryColor,
                    letterSpacing: 0.5,
                  ),
                  textAlign: TextAlign.center,
                ),

                SizedBox(height: ResponsiveUtils.hp(1)),

                // Sous-titre
                Obx(
                  () => Text(
                    controller.authMode.value == LoginAuthMode.qrCode
                        ? "Scannez votre QR code pour vous connecter"
                        : "Connectez-vous avec votre numéro de carte sociale",
                    style: TextStyle(
                      fontSize: ResponsiveUtils.fontSize(15),
                      color: AppTheme.textSecondaryColor,
                      fontWeight: FontWeight.w400,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: ResponsiveUtils.hp(3)),
                Obx(
                  () {
                    final isQr =
                        controller.authMode.value == LoginAuthMode.qrCode;

                    return Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(ResponsiveUtils.wp(1.5)),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius:
                                BorderRadius.circular(ResponsiveUtils.wp(4)),
                            border: Border.all(
                              color:
                                  AppTheme.primaryColor.withValues(alpha: 0.15),
                            ),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.05),
                                blurRadius: 10,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: GestureDetector(
                                  onTap: () => controller
                                      .setAuthMode(LoginAuthMode.qrCode),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtils.hp(1.5),
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.authMode.value ==
                                              LoginAuthMode.qrCode
                                          ? AppTheme.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(3)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.qr_code_scanner_rounded,
                                          size: ResponsiveUtils.wp(5),
                                          color: controller.authMode.value ==
                                                  LoginAuthMode.qrCode
                                              ? Colors.white
                                              : AppTheme.textPrimaryColor,
                                        ),
                                        SizedBox(width: ResponsiveUtils.wp(2)),
                                        Text(
                                          "QR Code",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtils.fontSize(14),
                                            fontWeight: FontWeight.w600,
                                            color: controller.authMode.value ==
                                                    LoginAuthMode.qrCode
                                                ? Colors.white
                                                : AppTheme.textPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: ResponsiveUtils.wp(2)),
                              Expanded(
                                child: GestureDetector(
                                  onTap: () =>
                                      controller.setAuthMode(LoginAuthMode.ncs),
                                  child: Container(
                                    padding: EdgeInsets.symmetric(
                                      vertical: ResponsiveUtils.hp(1.5),
                                    ),
                                    decoration: BoxDecoration(
                                      color: controller.authMode.value ==
                                              LoginAuthMode.ncs
                                          ? AppTheme.primaryColor
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(3)),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Icon(
                                          Icons.badge_outlined,
                                          size: ResponsiveUtils.wp(5),
                                          color: controller.authMode.value ==
                                                  LoginAuthMode.ncs
                                              ? Colors.white
                                              : AppTheme.textPrimaryColor,
                                        ),
                                        SizedBox(width: ResponsiveUtils.wp(2)),
                                        Text(
                                          "NCS",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtils.fontSize(14),
                                            fontWeight: FontWeight.w600,
                                            color: controller.authMode.value ==
                                                    LoginAuthMode.ncs
                                                ? Colors.white
                                                : AppTheme.textPrimaryColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: ResponsiveUtils.hp(4)),
                        if (isQr)
                          GestureDetector(
                            onTap: () async {
                              var res = await Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) => AiBarcodeScanner(
                                    onDetect: (BarcodeCapture capture) {
                                      debugPrint(
                                          "Barcode detected: ${capture.barcodes.first.rawValue}");
                                      Navigator.of(context)
                                          .pop(capture.barcodes.first.rawValue);
                                    },
                                  ),
                                ),
                              );
                              debugPrint(res);
                              if (res != null) {
                                controller.code(res);
                                String? pass = await Get.bottomSheet(
                                  Container(
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(
                                            ResponsiveUtils.wp(8)),
                                        topRight: Radius.circular(
                                            ResponsiveUtils.wp(8)),
                                      ),
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 10,
                                          spreadRadius: 0,
                                          offset: const Offset(0, -4),
                                        ),
                                      ],
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: ResponsiveUtils.wp(6),
                                      vertical: ResponsiveUtils.hp(3),
                                    ),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          width: ResponsiveUtils.wp(15),
                                          height: ResponsiveUtils.hp(0.7),
                                          decoration: BoxDecoration(
                                            color: Colors.grey
                                                .withValues(alpha: 0.3),
                                            borderRadius: BorderRadius.circular(
                                                ResponsiveUtils.wp(1)),
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(3)),
                                        Container(
                                          padding: EdgeInsets.all(
                                              ResponsiveUtils.wp(2)),
                                          decoration: BoxDecoration(
                                            color: AppTheme.backgroundColor,
                                            shape: BoxShape.circle,
                                            boxShadow: [
                                              BoxShadow(
                                                color: AppTheme.primaryColor
                                                    .withValues(alpha: 0.1),
                                                blurRadius: 8,
                                                spreadRadius: 0,
                                                offset: const Offset(0, 2),
                                              ),
                                            ],
                                          ),
                                          child: Icon(
                                            Icons.lock_rounded,
                                            color: AppTheme.primaryColor,
                                            size: ResponsiveUtils.wp(10),
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(2)),
                                        Text(
                                          "ENTRER VOTRE CODE SECRET",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtils.fontSize(18),
                                            fontWeight: FontWeight.bold,
                                            color: AppTheme.textPrimaryColor,
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(1)),
                                        Text(
                                          "Veuillez saisir votre code à 6 chiffres",
                                          style: TextStyle(
                                            fontSize:
                                                ResponsiveUtils.fontSize(14),
                                            color: AppTheme.textSecondaryColor,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(3)),
                                        Pinput(
                                          length: 6,
                                          autofocus: true,
                                          defaultPinTheme: defaultPinTheme,
                                          focusedPinTheme: focusedPinTheme,
                                          submittedPinTheme: submittedPinTheme,
                                          onCompleted: (pin) {
                                            Get.back(result: pin);
                                          },
                                          keyboardType: TextInputType.number,
                                          pinputAutovalidateMode:
                                              PinputAutovalidateMode.onSubmit,
                                          obscureText: true,
                                          obscuringCharacter: '•',
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(3)),
                                        InkWell(
                                          onTap: () {
                                            Get.back(result: "");
                                          },
                                          child: Container(
                                            width: double.infinity,
                                            padding: EdgeInsets.symmetric(
                                              vertical: ResponsiveUtils.hp(1.5),
                                            ),
                                            decoration: BoxDecoration(
                                              color: Colors.grey
                                                  .withValues(alpha: 0.2),
                                              borderRadius:
                                                  BorderRadius.circular(
                                                      ResponsiveUtils.wp(2)),
                                            ),
                                            child: Center(
                                              child: Text(
                                                "ANNULER",
                                                style: TextStyle(
                                                  fontSize:
                                                      ResponsiveUtils.fontSize(
                                                          14),
                                                  fontWeight: FontWeight.bold,
                                                  color: AppTheme
                                                      .textSecondaryColor,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: ResponsiveUtils.hp(2)),
                                      ],
                                    ),
                                  ),
                                  isScrollControlled: true,
                                  isDismissible: false,
                                  enableDrag: true,
                                  backgroundColor: Colors.transparent,
                                );
                                controller.password(pass ?? '');
                                if (pass != "") {
                                  controller.login();
                                }
                              } else {
                                Get.snackbar(
                                    "Scan message", "Le Scan a echoue !",
                                    backgroundColor: Colors.red,
                                    colorText: Colors.white);
                              }
                            },
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                TweenAnimationBuilder(
                                  duration: const Duration(seconds: 2),
                                  tween: Tween<double>(begin: 0, end: 1),
                                  builder: (context, double value, child) {
                                    return Transform.scale(
                                      scale: 0.9 + (value * 0.1),
                                      child: Opacity(
                                        opacity: 1 - (value * 0.3),
                                        child: Container(
                                          width: ResponsiveUtils.wp(70),
                                          height: ResponsiveUtils.wp(70),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                              color: AppTheme.primaryColor
                                                  .withValues(alpha: 0.2),
                                              width: 2,
                                            ),
                                          ),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                Container(
                                  width: ResponsiveUtils.wp(60),
                                  height: ResponsiveUtils.wp(60),
                                  padding:
                                      EdgeInsets.all(ResponsiveUtils.wp(4)),
                                  decoration: BoxDecoration(
                                    color: AppTheme.primaryColor,
                                    borderRadius: BorderRadius.circular(
                                        ResponsiveUtils.wp(8)),
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppTheme.primaryColor
                                            .withValues(alpha: 0.4),
                                        blurRadius: 25,
                                        spreadRadius: 0,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(ResponsiveUtils.wp(3)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(6)),
                                    ),
                                    child: PrettyQrView.data(
                                      data: 'e-campus',
                                      decoration: const PrettyQrDecoration(
                                        shape: PrettyQrSmoothSymbol(
                                          color: AppTheme.primaryColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  child: Container(
                                    padding:
                                        EdgeInsets.all(ResponsiveUtils.wp(2)),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      boxShadow: [
                                        BoxShadow(
                                          color: Colors.black
                                              .withValues(alpha: 0.1),
                                          blurRadius: 8,
                                          offset: const Offset(0, 2),
                                        ),
                                      ],
                                    ),
                                    child: Icon(
                                      Icons.qr_code_scanner_rounded,
                                      color: AppTheme.primaryColor,
                                      size: ResponsiveUtils.wp(8),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        else
                          Container(
                            padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(ResponsiveUtils.wp(6)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.06),
                                  blurRadius: 20,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                              border: Border.all(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.12),
                              ),
                            ),
                            child: Column(
                              children: [
                                TextField(
                                  keyboardType: TextInputType.text,
                                  onChanged: (value) => controller.ncs(value),
                                  decoration: InputDecoration(
                                    labelText: "Numéro carte sociale (NCS)",
                                    prefixIcon:
                                        const Icon(Icons.badge_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(4)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: ResponsiveUtils.hp(2)),
                                TextField(
                                  obscureText: true,
                                  onChanged: (value) =>
                                      controller.password(value),
                                  decoration: InputDecoration(
                                    labelText: "Mot de passe",
                                    prefixIcon: const Icon(Icons.lock_outline),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          ResponsiveUtils.wp(4)),
                                    ),
                                  ),
                                ),
                                SizedBox(height: ResponsiveUtils.hp(3)),
                                SizedBox(
                                  width: double.infinity,
                                  child: ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: AppTheme.primaryColor,
                                      foregroundColor: Colors.white,
                                      padding: EdgeInsets.symmetric(
                                        vertical: ResponsiveUtils.hp(1.6),
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(
                                            ResponsiveUtils.wp(4)),
                                      ),
                                    ),
                                    onPressed: () {
                                      final ncs = controller.ncs.value.trim();
                                      final pass =
                                          controller.password.value.trim();

                                      if (ncs.isEmpty || pass.isEmpty) {
                                        Get.snackbar('Login Message',
                                            'Veuillez saisir votre NCS et votre mot de passe',
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                        return;
                                      }

                                      final passError =
                                          controller.validatePassword(pass);
                                      if (passError != null) {
                                        Get.snackbar('Login Message', passError,
                                            backgroundColor: Colors.red,
                                            colorText: Colors.white);
                                        return;
                                      }

                                      controller.loginWithNcs();
                                    },
                                    child: Text(
                                      "SE CONNECTER",
                                      style: TextStyle(
                                        fontSize: ResponsiveUtils.fontSize(15),
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.5,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        if (isQr) ...[
                          SizedBox(height: ResponsiveUtils.hp(4)),
                          Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: ResponsiveUtils.wp(6),
                              vertical: ResponsiveUtils.hp(2),
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.circular(ResponsiveUtils.wp(5)),
                              border: Border.all(
                                color: AppTheme.primaryColor
                                    .withValues(alpha: 0.2),
                                width: 1.5,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: AppTheme.primaryColor
                                      .withValues(alpha: 0.08),
                                  blurRadius: 15,
                                  spreadRadius: 0,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(
                                  Icons.touch_app_rounded,
                                  color: AppTheme.primaryColor,
                                  size: ResponsiveUtils.wp(6),
                                ),
                                SizedBox(width: ResponsiveUtils.wp(3)),
                                Flexible(
                                  child: Text(
                                    "Appuyez sur le QR code pour scanner",
                                    style: TextStyle(
                                      fontSize: ResponsiveUtils.fontSize(15),
                                      fontWeight: FontWeight.w600,
                                      color: AppTheme.primaryColor,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ],
                    );
                  },
                ),

                SizedBox(height: ResponsiveUtils.hp(3)),

                // Informations supplémentaires
                Text(
                  "Connexion sécurisée",
                  style: TextStyle(
                    fontSize: ResponsiveUtils.fontSize(13),
                    color: AppTheme.textSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
