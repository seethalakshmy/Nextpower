
import 'package:flutter/material.dart';

import '../theme/app_colors.dart';

class CustomBorders{

  OutlineInputBorder textFieldBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(5.0),
        ),
        borderSide:BorderSide(color:AppColors.textBoxBorder)
    );
  }
}