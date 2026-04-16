import 'package:get/get.dart';

mixin Validations {
  String? validateName(String value) {
    return value.length >= 2 ? null : "doit avoir plus d'une caractères";
  }

  String? validatePassword(String value) {
    return value.length >= 6
        ? null
        : "doit avoir un mot de passe au moins 6 caractères";
  }

  String? validateEmail(String value) {
    return GetUtils.isEmail(value) ? null : "email invalide";
  }
}
