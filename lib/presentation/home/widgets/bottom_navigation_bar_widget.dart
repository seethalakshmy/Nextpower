import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';

class BottomNavigationBarWidget extends GetView<HomeController> {
  const BottomNavigationBarWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Container(
        color: Colors.white,
        child: Obx(
          () => Row(
            children: [
              _BottomBarItemWidget(
                assetPath: Assets.iconsMenuStation,
                title: LocaleKeys.stations,
                isSelected:
                    controller.selectedIndex.value == controller.stationIndex,
                onTap: () {
                  controller.setSelectedIndex(controller.stationIndex);
                },
              ),
              _BottomBarItemWidget(
                assetPath: Assets.iconsMenuChargingHistory,
                title: LocaleKeys.history,
                isSelected:
                    controller.selectedIndex.value == controller.historyIndex,
                onTap: () {
                  controller.setSelectedIndex(controller.historyIndex);
                },
              ),
              _BottomBarItemWidget(
                assetPath: Assets.iconsFavouriteIcon,
                title: LocaleKeys.favourites,
                isSelected:
                    controller.selectedIndex.value == controller.favoritesIndex,
                onTap: () {
                  controller.setSelectedIndex(controller.favoritesIndex);
                },
              ),
              _BottomBarItemWidget(
                assetPath: Assets.iconsWalletIcon,
                title: LocaleKeys.wallet,
                isSelected:
                    controller.selectedIndex.value == controller.walletIndex,
                onTap: () {
                  controller.setSelectedIndex(controller.walletIndex);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class _BottomBarItemWidget extends StatelessWidget {
  const _BottomBarItemWidget({
    required this.assetPath,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String assetPath;
  final String title;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          children: [
            const SizedBox(height: 10),
            SvgImageUtils().showSvgFromAsset(assetPath,
                color: isSelected ? AppColors.primaryGreen : null),
            TitleWidget(
              title: translate(title),
              color: isSelected ? AppColors.primaryGreen : null,
            ),
            const SizedBox(height: 5)
          ],
        ),
      ),
    );
  }
}