import 'package:flutter_svg/flutter_svg.dart';

class SvgImageUtils {
  SvgPicture showSvgFromAsset(String assetPath) => SvgPicture.asset(
        assetPath,
      );
}