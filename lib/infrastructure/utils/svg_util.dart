import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageUtils {
  dynamic showSvgFromAsset(String assetPath,
      {double? width, double? height, Color? color}) {
    if (assetPath.split(".").last == "svg") {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
        // color: Colors.red,
        colorFilter:
            color != null ? ColorFilter.mode(color, BlendMode.srcIn) : null,
      );
    } else if (assetPath.split(".").last == "png" ||
        assetPath.split(".").last == "jpg" ||
        assetPath.split(".").last == "jpeg") {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
      );
    }
  }
}