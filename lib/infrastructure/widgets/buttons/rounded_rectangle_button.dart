import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';

class RoundedRectangleButton extends StatelessWidget {
  const RoundedRectangleButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 30.0,
    required this.text,
    this.isLoading = false,
    this.loaderSize = 18,
    this.height,
    this.padding,
    this.asset = "",
    this.textSize,
    this.textColor,
  });

  final VoidCallback onPressed;
  final double borderRadius;
  final String text;
  final String asset;
  final bool isLoading;
  final double loaderSize;
  final double? height;
  final double? textSize;
  final Color? textColor;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 50,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
              padding: padding ?? EdgeInsets.zero,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
              backgroundColor: AppColors.primaryBlue),
          child: isLoading
              ? SizedBox(
                  height: loaderSize,
                  width: loaderSize,
                  child: const CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 2,
                  ),
                )
              : Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (asset.isNotEmpty)
                      SvgImageUtils()
                          .showSvgFromAsset(asset, width: 16, height: 16),
                    if (asset.isNotEmpty) const SizedBox(width: 5),
                    Text(
                      text.toUpperCase(),
                      style: TextStyle(
                        color: textColor ?? Colors.white,
                          fontSize: textSize ?? 18,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                )),
    );
  }
}