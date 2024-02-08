import 'package:flutter/material.dart';

class AppColors {
  static Color primaryGreen = fromHex('#81B622');
  static Color primaryBlue = fromHex('#0093EA');
  static Color labelColor = fromHex('#596076');
  static Color labelColor2 = fromHex('#363D52');
  static Color textTitleColor = fromHex('#2c3238');
  static Color iconColor = fromHex('#6B7186');
  static Color btmTextColor = fromHex('#565F7D');
  static Color labelMediumColor = fromHex('#707688');
  static Color fieldColor = fromHex('#A6B8C2');
  static Color labelTextColor3 = fromHex('#939AB1'); //terms and conditions
  static Color labelTextColor4 = fromHex('#2D444B');
  static Color tabNotSelectedColor = fromHex('#CCE1ED');
  static Color optionsNotSelectedColor = fromHex('#F1F7FF');
  static Color minusRed = fromHex('#F7514E');
  static Color addGreen = fromHex('#1EBF4B');
  static Color dialogPink = fromHex('#DA1987');
  static Color dialogLightPink = fromHex('#FFE7F7');
  static Color dialogGreen = fromHex('#0AB868');
  static Color dialogLightGreen = fromHex('#E5FFEE');
  static Color dialogOrange = fromHex('#F89014');
  static Color dialogLightOrange = fromHex('#FFEED9');
  static Color tabUnderlineSelectedColor = fromHex('#03507E');
  static Color availableGreen = fromHex('#1BC182');
  static Color homeIconColor = fromHex('#003784');
  static Color greenColor = fromHex('#ABF428');
  static Color dropShadow = fromHex('#A5B7D7');
  static Color switchInactiveColor = fromHex('#D5E5EF');
  static Color walletTextBorderColor = fromHex('#D3DADE');
  static Color walletListTextColor = fromHex('#7D8190');
  static Color darkOrange = fromHex('#DF865F');

  static Color primaryColor = fromHex('#0094EA');
  static Color successGreen = fromHex('#62DF85');
  static Color walletListBackground = fromHex('#5D93F4');

  static Color errorRed = Colors.red[700]!;

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}