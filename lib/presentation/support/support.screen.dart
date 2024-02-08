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

import '../my.address/widgets/show_address_widget.dart';
import '../station.details/widgets/overview_widget.dart';
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
                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.center,
                          //   children: [
                          //     _ClickableTextWidget(
                          //       text: translate(LocaleKeys.termsAndConditions),
                          //       onPressed: () {},
                          //     ),
                          //     _ClickableTextWidget(
                          //       text: translate(LocaleKeys.privacyPolicy),
                          //       onPressed: () {},
                          //     ),
                          //   ],
                          // ),
                          const SizedBox(height: 20),
                          TitleWidget(
                            title: translate(LocaleKeys.contactUs),
                            fontSize: 19,
                            fontWeight: FontWeight.w600,
                          ),
                          const SizedBox(height: 10),
                          // Text(controller.aboutUs?.data ?? "")
                          ShowAddressWidget(
                              addressLine1: "addressLine1",
                              addressLine2: "addressLine2",
                              city: "city",
                              country: "country",
                              state: "state",
                              postalCode: "postalCode"),
                          const SizedBox(height: 10),
                          // SmallIconLabelWidget(
                          //   assetPath: Assets.iconsTime,
                          //   label: controller.aboutUs?.openTime ?? "",
                          // ),
                          const SizedBox(height: 10),
                          SmallIconLabelWidget(
                            assetPath: Assets.iconsCallBig,
                            label: "1234567890",
                          ),
                          const SizedBox(height: 10),
                          SmallIconLabelWidget(
                            assetPath: Assets.iconsEmail,
                            label:  "tes@gmail.com",
                          ),
                        ],
                      ),
                    ))
              ],
            ),
            // child: Column(
            //   crossAxisAlignment: CrossAxisAlignment.center,
            //   children: [
            //     SvgImageUtils().showSvgFromAsset(Assets.iconsSupport),
            //     const SizedBox(height: 30),
            //     _ButtonItem(
            //       asset: Assets.iconsMenuStation,
            //       onPressed: () {
            //         NavigationUtils().callChargingBillingPage(1);
            //       },
            //       title: translate(LocaleKeys.charging),
            //     ),
            //     const SizedBox(height: 10),
            //     _ButtonItem(
            //       asset: Assets.iconsMenuStation,
            //       onPressed: () {
            //         NavigationUtils().callChargingBillingPage(2);
            //       },
            //       title: translate(LocaleKeys.billing),
            //     )
            //   ],
            // ),
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

// class _ButtonItem extends StatelessWidget {
//   const _ButtonItem({
//     super.key,
//     required this.title,
//     required this.asset,
//     required this.onPressed,
//   });
//
//   final String title;
//   final String asset;
//   final VoidCallback onPressed;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextButton(
//         onPressed: onPressed,
//         style: TextButton.styleFrom(
//             padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//             shape: RoundedRectangleBorder(
//                 side: BorderSide(color: AppColors.primaryColor),
//                 borderRadius: BorderRadius.circular(5))),
//         child: Row(
//           children: [
//             SvgImageUtils()
//                 .showSvgFromAsset(asset, color: AppColors.primaryColor),
//             const SizedBox(
//               width: 10,
//             ),
//             Expanded(
//               child: TitleWidget(
//                 title: title,
//                 color: AppColors.primaryColor,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             Icon(
//               Icons.arrow_forward_ios_rounded,
//               color: AppColors.primaryColor,
//               size: 16,
//             )
//           ],
//         ));
//   }
// }
