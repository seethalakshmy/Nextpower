import 'package:flutter/services.dart';

class InputFormatterUtils {
  List<TextInputFormatter> onlyNumber() {
    return [FilteringTextInputFormatter(RegExp("[0-9]"), allow: true)];
  }
}