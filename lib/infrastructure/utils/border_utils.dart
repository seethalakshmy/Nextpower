import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBorders {
  OutlineInputBorder textFieldBorder({Color? color}) {
    return OutlineInputBorder(
        borderRadius: borderCircularRadius5(),
        borderSide: BorderSide(color: color ?? AppColors.textBoxBorder));
  }

  BoxDecoration containerBorder({Color? color}) {
    return BoxDecoration(
        border: Border.all(
          color: color ?? AppColors.textBoxBorder,
        ),
        borderRadius: borderCircularRadius5());
  }

  BorderRadius borderCircularRadius5() {
    return const BorderRadius.all(
      Radius.circular(5.0),
    );
  }
}