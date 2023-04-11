import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

import 'controllers/wallet_list.controller.dart';

class WalletListScreen extends GetView<WalletListController> {
  const WalletListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(
          title:
              "${translate(LocaleKeys.wallet)} ${translate(LocaleKeys.history)}",
        ),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : Container(
                  margin: const EdgeInsets.only(top: 20.0),
                  child: ListView.separated(
                    separatorBuilder: (context, index) {
                      return const SizedBox(height: 10);
                    },
                    itemCount: controller.list.length,
                    itemBuilder: (context, index) {
                      return CustomCardView(
                          padding: const EdgeInsets.only(
                              top: 10, right: 20, left: 20, bottom: 20),
                          child: Row(
                            children: [
                              Container(
                                  width: 45,
                                  height: 45,
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: AppColors.walletListBackground,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: SvgImageUtils().showSvgFromAsset(
                                      Assets.iconsWalletActive,
                                      color: Colors.white,
                                      width: 20,
                                      height: 19)),
                              const SizedBox(width: 10),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  TitleWidget(
                                    title:
                                        (controller.list[index].amount ?? 0.0)
                                            .toString(),
                                    fontSize: 18,
                                  ),
                                  Wrap(
                                    crossAxisAlignment:
                                        WrapCrossAlignment.center,
                                    children: [
                                      // Icon(Icons.calendar_today_outlined),
                                      SvgImageUtils().showSvgFromAsset(
                                        Assets.iconsCalender,
                                      ),
                                      const SizedBox(width: 5),
                                      TitleWidget(
                                          title:
                                              controller.list[index].date ?? "",
                                          fontSize: 14,
                                          color: AppColors.walletListTextColor),
                                    ],
                                  )
                                ],
                              )
                            ],
                          ));
                    },
                  ),
                ),
        ));
  }
}