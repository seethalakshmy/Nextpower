import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

import 'controllers/support.controller.dart';

class SupportScreen extends GetView<SupportController> {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(title: translate(LocaleKeys.support)),
      body: CustomCardView(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
          margin: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
          child: IntrinsicHeight(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgImageUtils().showSvgFromAsset(Assets.iconsSupport),
                const SizedBox(height: 30),
                _ButtonItem(
                  asset: Assets.iconsMenuStation,
                  onPressed: () {
                    NavigationUtils().callChargingBillingPage(1);
                  },
                  title: translate(LocaleKeys.charging),
                ),
                const SizedBox(height: 10),
                _ButtonItem(
                  asset: Assets.iconsMenuStation,
                  onPressed: () {
                    NavigationUtils().callChargingBillingPage(2);
                  },
                  title: translate(LocaleKeys.billing),
                )
              ],
            ),
          )),
    );
  }
}

class _ButtonItem extends StatelessWidget {
  const _ButtonItem({
    super.key,
    required this.title,
    required this.asset,
    required this.onPressed,
  });

  final String title;
  final String asset;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return TextButton(
        onPressed: onPressed,
        style: TextButton.styleFrom(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
            shape: RoundedRectangleBorder(
                side: BorderSide(color: AppColors.primaryColor),
                borderRadius: BorderRadius.circular(5))),
        child: Row(
          children: [
            SvgImageUtils()
                .showSvgFromAsset(asset, color: AppColors.primaryColor),
            const SizedBox(
              width: 10,
            ),
            Expanded(
              child: TitleWidget(
                title: title,
                color: AppColors.primaryColor,
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios_rounded,
              color: AppColors.primaryColor,
              size: 16,
            )
          ],
        ));
  }
}