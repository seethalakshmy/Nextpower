import 'package:flutter/material.dart';

import 'border_utils.dart';

class CustomDecorationUtils {
  InputDecoration textFieldDecoration({
    required String hintText,
    Color? color,
    Widget? suffix,
  }) {
    return InputDecoration(
      suffix: suffix,
      hintText: hintText,
      isDense: true,
      disabledBorder: CustomBorders().textFieldBorder(color: color),
      enabledBorder: CustomBorders().textFieldBorder(color: color),
      border: CustomBorders().textFieldBorder(color: color),
    );
  }
}