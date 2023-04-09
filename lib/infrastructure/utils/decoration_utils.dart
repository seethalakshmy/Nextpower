import 'package:flutter/material.dart';

import 'border_utils.dart';

class CustomDecorationUtils {
  InputDecoration textFieldDecoration({
    // required String hintText,
    Color? color,
    Widget? suffix,
  }) {
    return InputDecoration(
      suffixIcon: Padding(
        padding: const EdgeInsets.only(right: 4.0),
        child: suffix,
      ),
      suffixIconConstraints: const BoxConstraints(
          maxHeight: 28, minHeight: 28, minWidth: 28, maxWidth: 28),
      // hintText: hintText,
      isDense: false,
      contentPadding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
      // errorBorder: CustomBorders().textFieldBorder(color: color),
      disabledBorder: CustomBorders().textFieldBorder(color: color),
      enabledBorder: CustomBorders().textFieldBorder(color: color),
      border: CustomBorders().textFieldBorder(color: color),
    );
  }
}