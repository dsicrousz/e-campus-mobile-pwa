import 'package:ecampusv2/app/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:introduction_screen/introduction_screen.dart';

import '../controllers/introduction_controller.dart';
import '../../../utils/responsive_utils.dart';
import '../../../utils/app_theme.dart';

class IntroductionView extends GetView<IntroductionController> {
  IntroductionView({super.key});
  final GetStorage storage = GetStorage();

  @override
  Widget build(BuildContext context) {
    // Initialisation des utilitaires responsifs
    ResponsiveUtils.init(context);

    // Définition des styles de texte responsifs
    final titleStyle = TextStyle(
      fontSize: ResponsiveUtils.fontSize(24),
      fontWeight: FontWeight.bold,
      color: AppTheme.textPrimaryColor,
      height: 1.3,
    );

    final bodyStyle = TextStyle(
      fontSize: ResponsiveUtils.fontSize(15),
      color: AppTheme.textSecondaryColor,
      height: 1.5,
    );

    // Taille des images responsive
    final imageHeight = ResponsiveUtils.hp(22);
    final imageWidth = ResponsiveUtils.wp(60);

    // Liste des pages avec éléments responsifs
    final pages = [
      PageViewModel(
        bodyWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Text(
            "Scannez simplement le QR code de votre carte sociale et utilisez le code 123456 comme mot de passe par défaut pour votre première connexion.",
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
        image: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Cercle de fond
              Container(
                width: ResponsiveUtils.wp(70),
                height: ResponsiveUtils.wp(70),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
              // Image avec ombre
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(6)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.primaryColor.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                child: Image.asset(
                  'assets/qr.png',
                  height: imageHeight,
                  width: imageWidth,
                  fit: BoxFit.contain,
                ),
              ),
            ],
          ),
        ),
        titleWidget: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Text(
            "Connexion rapide et sécurisée",
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titlePadding: EdgeInsets.only(top: ResponsiveUtils.hp(4)),
          bodyPadding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          imagePadding: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        ),
      ),
      PageViewModel(
        bodyWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Text(
            "Pour garantir la sécurité de votre compte, nous vous recommandons fortement de modifier votre mot de passe par défaut dès votre première connexion.",
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
        image: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Container(
                width: ResponsiveUtils.wp(70),
                height: ResponsiveUtils.wp(70),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withValues(alpha: 0.1),
                  shape: BoxShape.circle,
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(6)),
                  boxShadow: [
                    BoxShadow(
                      color: AppTheme.secondaryColor.withValues(alpha: 0.2),
                      blurRadius: 20,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                padding: EdgeInsets.all(ResponsiveUtils.wp(5)),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
                  child: Image.asset(
                    'assets/codesecret.jpg',
                    height: imageHeight,
                    width: imageWidth,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ),
        titleWidget: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Text(
            "Sécurisez votre compte",
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titlePadding: EdgeInsets.only(top: ResponsiveUtils.hp(4)),
          bodyPadding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          imagePadding: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        ),
      ),
      PageViewModel(
        bodyWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Text(
            "Rendez-vous chez un point de recharge agréé avec votre application mobile ou votre carte sociale pour recharger votre compte facilement.",
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
        image: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            child: Image.asset(
              'assets/codeqr.jpg',
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Text(
            "Rechargez votre compte",
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titlePadding: EdgeInsets.only(top: ResponsiveUtils.hp(4)),
          bodyPadding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          imagePadding: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        ),
      ),
      PageViewModel(
        bodyWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Text(
            "Saisissez le numéro de carte sociale du bénéficiaire et le montant que vous souhaitez transférer. Validez ensuite avec votre code secret.",
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
        image: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            child: Image.asset(
              'assets/transfert.jpg',
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Text(
            "Transférez de l'argent",
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titlePadding: EdgeInsets.only(top: ResponsiveUtils.hp(4)),
          bodyPadding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          imagePadding: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        ),
      ),
      PageViewModel(
        bodyWidget: Container(
          padding: EdgeInsets.symmetric(
            horizontal: ResponsiveUtils.wp(5),
            vertical: ResponsiveUtils.hp(1),
          ),
          child: Text(
            "Présentez votre QR code depuis l'application ou votre carte sociale au commerçant. Le paiement sera instantané et sécurisé.",
            style: bodyStyle,
            textAlign: TextAlign.center,
          ),
        ),
        image: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(5)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.1),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          padding: EdgeInsets.all(ResponsiveUtils.wp(4)),
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(ResponsiveUtils.wp(3)),
            child: Image.asset(
              'assets/codeqr.jpg',
              height: imageHeight,
              width: imageWidth,
              fit: BoxFit.cover,
            ),
          ),
        ),
        titleWidget: Container(
          margin: EdgeInsets.only(top: ResponsiveUtils.hp(3)),
          child: Text(
            "Payez vos services",
            style: titleStyle,
            textAlign: TextAlign.center,
          ),
        ),
        decoration: PageDecoration(
          pageColor: Colors.white,
          titlePadding: EdgeInsets.only(top: ResponsiveUtils.hp(4)),
          bodyPadding: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(4)),
          imagePadding: EdgeInsets.only(top: ResponsiveUtils.hp(2)),
        ),
      ),
    ];

    return Scaffold(
      backgroundColor: AppTheme.backgroundColor,
      body: SafeArea(
        child: IntroductionScreen(
          pages: pages,
          showSkipButton: true,
          showNextButton: true,
          skip: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(4),
              vertical: ResponsiveUtils.hp(1),
            ),
            decoration: BoxDecoration(
              color: Colors.grey.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(5)),
            ),
            child: Text(
              "Passer",
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(14),
                color: AppTheme.textSecondaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          done: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(6),
              vertical: ResponsiveUtils.hp(1.2),
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(5)),
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withValues(alpha: 0.4),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Text(
              "Commencer",
              style: TextStyle(
                fontSize: ResponsiveUtils.fontSize(14),
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          next: Container(
            padding: EdgeInsets.symmetric(
              horizontal: ResponsiveUtils.wp(3),
              vertical: ResponsiveUtils.hp(0.8),
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(4)),
            ),
            child: Icon(
              Icons.arrow_forward_rounded,
              color: Colors.white,
              size: ResponsiveUtils.wp(5),
            ),
          ),
          dotsDecorator: DotsDecorator(
            size: Size.square(ResponsiveUtils.wp(2)),
            activeSize: Size(ResponsiveUtils.wp(6), ResponsiveUtils.wp(2)),
            activeColor: AppTheme.primaryColor,
            color: Colors.grey.withValues(alpha: 0.3),
            spacing: EdgeInsets.symmetric(horizontal: ResponsiveUtils.wp(1)),
            activeShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(ResponsiveUtils.wp(1.5)),
            ),
          ),
          onSkip: () {
            storage.write("isIntro", true);
            storage.write("hasCompletedProfile", false);
            Get.offAllNamed(Routes.SPLASH);
          },
          onDone: () {
            storage.write("isIntro", true);
            storage.write("hasCompletedProfile", false);
            Get.offAllNamed(Routes.SPLASH);
          },
        ),
      ),
    );
  }
}
