import 'package:flutter/material.dart';

class AppColors {
  //Given

  static Color primaryGreen = fromHex('#81B622');
  static Color primaryBlue = fromHex('#0093EA');
  static Color labelColor = fromHex('#596076');
  static Color textTitleColor = fromHex('#2c3238');
  static Color iconColor = fromHex('#6B7186');
  static Color btmTextColor = fromHex('#565F7D');
  static Color labelMediumColor = fromHex('#707688');
  static Color fieldColor = fromHex('#A6B8C2');
  static Color labelTextColor3 = fromHex('#939AB1'); //terms and conditions

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