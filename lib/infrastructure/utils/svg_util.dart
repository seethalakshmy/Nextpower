import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SvgImageUtils {
  dynamic showSvgFromAsset(String assetPath, {double? width, double? height}) {
    if (assetPath.split(".").last == "svg") {
      return SvgPicture.asset(
        assetPath,
        width: width,
        height: height,
      );
    } else if (assetPath.split(".").last == "png") {
      return Image.asset(
        assetPath,
        width: width,
        height: height,
      );
    }
  }
}