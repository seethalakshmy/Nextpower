import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';

import '../../../infrastructure/widgets/text_fields/name_widget.dart';

class WalletView extends GetView<HomeController> {
  WalletView({super.key});
  final amountList = ["100", "200", "500", "1000", "2000", "5000", "10000"];

  @override
  Widget build(BuildContext context) {
    if (controller.walletDetail.value.status == true) {
      var wallet = controller.walletDetail.value.wallet;
      return Stack(
        children: [
          Column(
            children: [
              Expanded(
                  flex: 2,
                  child: Container(
                    padding:
                        const EdgeInsets.only(left: 20, right: 20, top: 30),
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            fit: BoxFit.fill,
                            image: AssetImage(Assets.iconsWalletBalanceBg))),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: TitleWidget(
                                  title:
                                      "\u20B9 ${wallet?.availableAmount ?? 0.0}",
                                  fontSize: 48,
                                  color: Colors.white,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TitleWidget(
                                title: translate(LocaleKeys.availableBalance),
                                fontSize: 20,
                                color: Colors.white,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                        // SvgImageUtils()
                        //     .showSvgFromAsset(Assets.iconsWalletVector)
                      ],
                    ),
                  )),
              Expanded(
                  child: Container(
                color: Colors.white,
              )),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            top: 160,
            child: CustomCardView(
                padding: const EdgeInsets.all(20),
                child: IntrinsicHeight(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TitleWidget(
                        title: translate(LocaleKeys.addMoneyToYourWallet),
                        fontSize: 19,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textTitleColor,
                      ),
                      SubtitleWidget(
                        subtitle:
                            translate(LocaleKeys.chargeYourEvAtAnyStations),
                        fontWeight: FontWeight.w400,
                      ),
                      const SizedBox(height: 20),
                      CommonTextFieldWidget(
                          title: "",
                          editingController: controller.walletBalanceController,
                          fontSize: 25,
                          onChanged: (value) {},
                          validator: (value) {
                            return null;
                          }),
                      Obx(() => Wrap(
                            children: (amountList).map((amount) {
                              int index = (amountList)
                                  .indexWhere((element) => element == amount);
                              return GestureDetector(
                                onTap: () {
                                  controller.setWalletAmountChosenIndex(
                                      index: index, amount: int.parse(amount));
                                },
                                child: Container(
                                    margin: const EdgeInsets.only(
                                        right: 5, top: 10),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 20, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: controller
                                                    .walletChosenAmountIndex
                                                    .value ==
                                                index
                                            ? AppColors.primaryGreen
                                            : Colors.transparent,
                                        border: Border.all(
                                            color: AppColors
                                                .walletTextBorderColor),
                                        borderRadius:
                                            BorderRadius.circular(30)),
                                    child: Text(
                                      amount.toString(),
                                      style: TextStyle(
                                          color: controller
                                                      .walletChosenAmountIndex
                                                      .value ==
                                                  index
                                              ? Colors.white
                                              : AppColors.walletListTextColor,
                                          fontSize: 14),
                                    )),
                              );
                            }).toList(),
                          )),
                      const SizedBox(height: 30),
                      RoundedRectangleButton(
                          onPressed: () {
                            controller.openCheckout();
                          },
                          height: 55,
                          padding: EdgeInsets.zero,
                          text:
                              translate(LocaleKeys.proceedToPay).toUpperCase()),
                      const SizedBox(height: 20),
                      TextButton(
                        onPressed: () {
                          NavigationUtils().callWalletListPage();
                        },
                        style: TextButton.styleFrom(
                          splashFactory: NoSplash.splashFactory,
                        ).copyWith(
                          overlayColor:
                              MaterialStateProperty.all(Colors.transparent),
                        ),
                        child: Center(
                          child: Text(
                            "${translate(LocaleKeys.wallet)} ${translate(LocaleKeys.history)}",
                            style: TextStyle(
                                fontSize: 16,
                                decoration: TextDecoration.underline,
                                color: AppColors.labelColor),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                )),
          ),
        ],
      );
    } else {
      return EmptyListView(
          subTitle: translate(LocaleKeys.somethingWentWrongPleaseTryAgainLater),
          title: translate(LocaleKeys.sorry));
    }
  }
}
