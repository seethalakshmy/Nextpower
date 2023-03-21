import 'package:flutter/material.dart';

class AppColors {
  static Color primaryGreen = fromHex('#81B622');
  static Color primaryBlue = fromHex('#0093EA');
  static Color textBoxBorder = fromHex('#A6B8C2');

  static Color primaryColor = fromHex('#0094EA');
  static Color successGreen = fromHex('#62DF85');
  static Color availableGreen = fromHex('#1BC183');
  static Color selectionColor = fromHex('#02507F');

  static Color errorRed = Colors.red[700]!;
  static Color descriptionTextColor = fromHex('#949AAC');
  static Color titleLabelTextColor = fromHex('#5A6077');
  static Color labelGreenTextColor = fromHex('#80B720');

  //color picked
  static Color subTitleTextColor2 = fromHex('#585F83');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}