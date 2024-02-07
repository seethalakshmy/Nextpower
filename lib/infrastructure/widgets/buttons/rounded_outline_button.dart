import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';

class RoundedOutlineButton extends StatelessWidget {
  const RoundedOutlineButton({
    super.key,
    required this.onPressed,
    this.borderRadius = 30.0,
    required this.text,
    this.isLoading = false,
    this.loaderSize = 18,
    this.height,
    this.asset = "",
    this.assetHeight,
  });

  final VoidCallback onPressed;
  final double borderRadius;
  final double? assetHeight;
  final String text;
  final bool isLoading;
  final double loaderSize;
  final double? height;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      child: OutlinedButton(
          onPressed: onPressed,
          style: OutlinedButton.styleFrom(
            side: BorderSide(color: AppColors.primaryBlue),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
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
                      SvgImageUtils().showSvgFromAsset(asset,
                          width: assetHeight ?? 16, height: assetHeight ?? 16),
                    if (asset.isNotEmpty) const SizedBox(width: 5),
                    Text(
                      text.toUpperCase(),
                      style: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.w600),
                    ),
                  ],
                )),
    );
  }
}