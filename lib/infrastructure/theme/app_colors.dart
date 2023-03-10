import 'dart:ui';

class AppColors {
  static Color primaryColor = fromHex('#0094EA');
  static Color successGreen = fromHex('#62DF85');
  static Color errorRed = fromHex('#F36157');
  static Color textBoxBorder = fromHex('#A6B8C2');
  static Color descriptionTextColor = fromHex('#949AAC');
  static Color titleLabelTextColor = fromHex('#5A6077');
  static Color labelGreenTextColor = fromHex('#80B720');

  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }
}