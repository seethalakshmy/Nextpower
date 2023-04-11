import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

import '../my.address/widgets/show_address_widget.dart';
import '../station.details/widgets/overview_widget.dart';
import 'controllers/about_us.controller.dart';

class AboutUsScreen extends GetView<AboutUsController> {
  const AboutUsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: translate(LocaleKeys.aboutUs),
        elevation: 0,
      ),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : Column(
              children: [
                Expanded(
                    child: SvgImageUtils().showSvgFromAsset(
                        Assets.iconsAboutusImage,
                        width: double.infinity)),
                Expanded(
                    flex: 2,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _ClickableTextWidget(
                                text: translate(LocaleKeys.termsAndConditions),
                                onPressed: () {},
                              ),
                              _ClickableTextWidget(
                                text: translate(LocaleKeys.privacyPolicy),
                                onPressed: () {},
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          TitleWidget(
                            title: translate(LocaleKeys.contactUs),
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 10),
                          ShowAddressWidget(
                              addressLine1:
                                  controller.aboutUs?.address?.addressLine1 ??
                                      "",
                              addressLine2:
                                  controller.aboutUs?.address?.addressLine2 ??
                                      "",
                              city: controller.aboutUs?.address?.city ?? "",
                              country:
                                  controller.aboutUs?.address?.countryName ??
                                      "",
                              state:
                                  controller.aboutUs?.address?.stateName ?? "",
                              postalCode:
                                  controller.aboutUs?.address?.postalCode ??
                                      ""),
                          const SizedBox(height: 10),
                          SmallIconLabelWidget(
                            assetPath: Assets.iconsTime,
                            label: controller.aboutUs?.openTime ?? "",
                          ),
                          const SizedBox(height: 10),
                          SmallIconLabelWidget(
                            assetPath: Assets.iconsCallBig,
                            label: controller.aboutUs?.mobileNumber ?? "",
                          ),
                          const SizedBox(height: 10),
                          SmallIconLabelWidget(
                            assetPath: Assets.iconsEmail,
                            label: controller.aboutUs?.mailId ?? "",
                          ),
                        ],
                      ),
                    ))
              ],
            )),
    );
  }
}

class _ClickableTextWidget extends StatelessWidget {
  const _ClickableTextWidget({
    required this.onPressed,
    required this.text,
  });

  final VoidCallback onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom().copyWith(
          overlayColor: MaterialStateProperty.all(Colors.transparent)),
      child: Text(
        text,
        style: TextStyle(
            color: AppColors.primaryColor,
            decoration: TextDecoration.underline),
      ),
    );
  }
}