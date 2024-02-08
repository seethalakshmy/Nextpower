import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class AppThemes {
  static ThemeData light = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.white,
    primaryColor: AppColors.primaryBlue,
    textTheme: GoogleFonts.poppinsTextTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
  );

  static ThemeData dark = ThemeData(
    useMaterial3: false,
    scaffoldBackgroundColor: Colors.black,
    primaryColor: AppColors.primaryBlue,
    textTheme: GoogleFonts.poppinsTextTheme(),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: Colors.transparent,
    ),
  );
}