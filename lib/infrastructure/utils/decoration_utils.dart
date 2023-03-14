import 'package:flutter/material.dart';

import 'border_utils.dart';

class CustomDecorationUtils{

  InputDecoration textFieldDecoration({required String hintText}) {
    return InputDecoration(
      hintText: hintText,
      isDense: true,
      disabledBorder: CustomBorders().textFieldBorder(),
      enabledBorder: CustomBorders().textFieldBorder(),
      border: CustomBorders().textFieldBorder(),
    );
  }
}