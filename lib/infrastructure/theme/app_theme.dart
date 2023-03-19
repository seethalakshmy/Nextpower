import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryBlue,
  );

  static ThemeData dark = ThemeData(
    scaffoldBackgroundColor: Colors.black,
    primaryColor: AppColors.primaryBlue,
  );
}