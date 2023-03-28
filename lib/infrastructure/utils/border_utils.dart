import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBorders {
  OutlineInputBorder textFieldBorder({Color? color, double? radius}) {
    return OutlineInputBorder(
        borderRadius: borderCircularRadius(radius: radius),
        borderSide: BorderSide(color: color ?? AppColors.fieldColor));
  }

  BoxDecoration containerBorder({Color? color}) {
    return BoxDecoration(
        border: Border.all(
          color: color ?? AppColors.fieldColor,
        ),
        borderRadius: borderCircularRadius());
  }

  BorderRadius borderCircularRadius({double? radius}) {
    return BorderRadius.all(
      Radius.circular(radius ?? 5.0),
    );
  }
}