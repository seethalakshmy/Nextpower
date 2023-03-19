import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: SizedBox(
      height: 20,
      width: 20,
      child: CircularProgressIndicator(
        color: AppColors.primaryColor,
        strokeWidth: 1,
      ),
    ));
  }
}