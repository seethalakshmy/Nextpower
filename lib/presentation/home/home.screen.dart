import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/drawer/custom_drawer.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/home/views/usage_history_view.dart';

import 'controllers/home.controller.dart';
import 'views/favourites_view.dart';
import 'views/station_view_with_state.dart';
import 'views/wallet_view.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Obx(() =>Scaffold(
        appBar: AppBar(
          title: const _AppBarTitleWidget(),
          centerTitle: false,
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: AppColors.textTitleColor),
        ),
        drawer: CustomDrawerWidget(controller: controller,),
        bottomNavigationBar: const BottomNavigationBarWidget(),
        floatingActionButton:
            controller.selectedIndex.value == controller.stationIndex
                ? FloatingActionButton(
                    heroTag: "QrCodeScanner",
                    onPressed: () {
                      NavigationUtils().callQrCodeScannerPage();
                    },
                    child: SvgImageUtils().showSvgFromAsset(Assets.iconsQrcode,
                        width: 24, height: 24),
                  )
                : null,
        body: const HomeContentView(),
      )),
    );
  }
}

class _AppBarTitleWidget extends GetView<HomeController> {
  const _AppBarTitleWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      String title = "";
      if (controller.selectedIndex.value == controller.stationIndex) {
        title = LocaleKeys.stations;
      } else if (controller.selectedIndex.value == controller.historyIndex) {
        title = LocaleKeys.usageHistory;
      } else if (controller.selectedIndex.value == controller.favoritesIndex) {
        title = LocaleKeys.favourites;
      } else if (controller.selectedIndex.value == controller.walletIndex) {
        title = LocaleKeys.wallet;
      } else {
        title = "";
      }
      return AppBarTitleWidget(title: translate(title));
    });
  }
}

class HomeContentView extends GetView<HomeController> {
  const HomeContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return LoadingWidget(
          size: 30,
          strokeWidth: 3,
          strokeColor: AppColors.primaryGreen,
        );
      }
      if (controller.selectedIndex.value == controller.stationIndex) {
        return const StationView();
      } else if (controller.selectedIndex.value == controller.historyIndex) {
        return const UsageHistoryView();
      } else if (controller.selectedIndex.value == controller.favoritesIndex) {
        return const FavouritesView();
      } else if (controller.selectedIndex.value == controller.walletIndex) {
        return const WalletView();
      } else {
        return Container();
      }
    });
  }
}