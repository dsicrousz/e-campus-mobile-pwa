import 'package:ecampusv2/app/modules/complete_profile/bindings/complete_profile_binding.dart';
import 'package:ecampusv2/app/modules/complete_profile/views/complete_profile_view.dart';
import 'package:ecampusv2/app/modules/introduction/bindings/introduction_binding.dart';
import 'package:ecampusv2/app/modules/introduction/views/introduction_view.dart';
import 'package:ecampusv2/app/modules/operation/bindings/operation_binding.dart';
import 'package:ecampusv2/app/modules/operation/views/operation_view.dart';
import 'package:ecampusv2/app/modules/allpubs/bindings/allpubs_binding.dart';
import 'package:ecampusv2/app/modules/allpubs/views/allpubs_view.dart';
import 'package:ecampusv2/app/modules/pub/bindings/pub_binding.dart';
import 'package:ecampusv2/app/modules/pub/views/pub_view.dart';
import 'package:ecampusv2/app/modules/pubdescription/bindings/pubdescription_binding.dart';
import 'package:ecampusv2/app/modules/pubdescription/views/pubdescription_view.dart';
import 'package:get/get.dart';
import '../modules/acceuil/bindings/acceuil_binding.dart';
import '../modules/acceuil/views/acceuil_view.dart';
import '../modules/alltransactions/bindings/alltransactions_binding.dart';
import '../modules/alltransactions/views/alltransactions_view.dart';
import '../modules/assistance/bindings/assistance_binding.dart';
import '../modules/assistance/views/assistance_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/passwordUpdate/bindings/password_update_binding.dart';
import '../modules/passwordUpdate/views/password_update_view.dart';
import '../modules/qrpage/bindings/qrpage_binding.dart';
import '../modules/qrpage/views/qrpage_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/virement/bindings/virement_binding.dart';
import '../modules/virement/views/virement_view.dart';
part 'app_routes.dart';

class AppPages {
  AppPages._();
  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.ACCEUIL,
      page: () => AcceuilView(),
      binding: AcceuilBinding(),
    ),
    GetPage(
      name: _Paths.ALLTRANSACTIONS,
      page: () => const AlltransactionsView(),
      binding: AlltransactionsBinding(),
    ),
    GetPage(
      name: _Paths.ASSISTANCE,
      page: () => const AssistanceView(),
      binding: AssistanceBinding(),
    ),
    GetPage(
      name: _Paths.QRPAGE,
      page: () => const QrpageView(),
      binding: QrpageBinding(),
    ),
    GetPage(
      name: _Paths.PASSWORD_UPDATE,
      page: () => const PasswordUpdateView(),
      binding: PasswordUpdateBinding(),
    ),
    GetPage(
      name: _Paths.VIREMENT,
      page: () => const VirementView(),
      binding: VirementBinding(),
    ),
    GetPage(
      name: _Paths.PUB,
      page: () => const PubView(),
      binding: PubBinding(),
    ),
    GetPage(
      name: _Paths.PUBDESCRIPTION,
      page: () => PubdescriptionView(),
      binding: PubdescriptionBinding(),
    ),
    GetPage(
      name: _Paths.OPERATION,
      page: () => OperationView(),
      binding: OperationBinding(),
    ),
    GetPage(
      name: _Paths.ALLPUBS,
      page: () => const AllpubsView(),
      binding: AllpubsBinding(),
    ),
    GetPage(
      name: _Paths.INTRODUCTION,
      page: () => IntroductionView(),
      binding: IntroductionBinding(),
    ),
    GetPage(
      name: _Paths.COMPLETE_PROFILE,
      page: () => const CompleteProfileView(),
      binding: CompleteProfileBinding(),
    ),
  ];
}
