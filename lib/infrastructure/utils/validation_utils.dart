import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

class ValidationUtils {
  String? mobileNumberEmptyValidation(String? number) {
    if (number == null || number.isEmpty) {
      return translate(LocaleKeys.mobileNumber);
    }
    return null;
  }

  String? mobileNumberValidation(String? number) {
    if (number == null || number.isEmpty) {
      return translate(LocaleKeys.mobileNumber);
    } else if (number.length < 9 || number.length > 12) {
    } else {
      return null;
    }
  }

  String? nameValidation(String? value) {
    if (value == null || value.isEmpty) {
      return translate(LocaleKeys.nameShouldntBeEmpty);
    } else if (value.length < 2) {
      return translate(LocaleKeys.enterValidName);
    }
    return null;
  }

  String? emailValidation(String? value) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    if (value == null || value.isEmpty) {
      return translate(LocaleKeys.emailShouldntBeEmpty);
    } else if (!RegExp(pattern).hasMatch(value.trim())) {
      return translate(LocaleKeys.enterValidEmailAddress);
    }
    return null;
  }

  bool isPassword(String value) {
    String pattern =
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$';
    RegExp regExp = RegExp(pattern);
    return regExp.hasMatch(value);
  }
}