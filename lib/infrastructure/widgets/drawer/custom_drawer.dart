import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';

import '../text/subtitle_widget.dart';

class CustomDrawerWidget extends StatelessWidget {
  const CustomDrawerWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: NavigationUtils().goBack,
                        icon: const Icon(Icons.close))),
                SizedBox(
                    width: 100,
                    height: 100,
                    child: Image.asset(
                      Assets.iconsMenuProfileImage,
                      fit: BoxFit.fill,
                    )),
                const SizedBox(height: 10),
                const Text(
                  'John Doe',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                const SubtitleWidget(
                  subtitle: '+91 1234567890',
                  fontWeight: FontWeight.w400,
                  fontSize: 16,
                ),
                Divider()
              ],
            ),
          ),
          _DrawerItem(
            title: LocaleKeys.stations,
            // onPressed: () => NavigationUtils().callStationList(),
            onPressed: () => NavigationUtils()
                .callHomePage(index: HomeController().stationIndex),
            asset: Assets.iconsMenuStation,
          ),
          _DrawerItem(
            title: LocaleKeys.profile,
            onPressed: () {
              Get.back();
              NavigationUtils().callProfile(isCalledFrom: 'drawer');
            },
            asset: Assets.iconsMenuProfile,
          ),
          _DrawerItem(
            title: LocaleKeys.wallet,
            onPressed: () => NavigationUtils()
                .callHomePage(index: HomeController().walletIndex),
            asset: Assets.iconsMenuWallet,
          ),
          _DrawerItem(
            title: LocaleKeys.usageHistory,
            onPressed: () => NavigationUtils()
                .callHomePage(index: HomeController().historyIndex),
            asset: Assets.iconsMenuChargingHistory,
          ),
          _DrawerItem(
            title: LocaleKeys.myVehicles,
            onPressed: () {
              Get.back();
              NavigationUtils().callMyVehicles();
            },
            asset: Assets.iconsMenuVehicle,
          ),
          _DrawerItem(
            title: LocaleKeys.myAddress,
            onPressed: () {
              Get.back();
              NavigationUtils().callMyAddress();
            },
            asset: Assets.iconsMenuMyAddress,
          ),
          _DrawerItem(
            title: LocaleKeys.rfidTag,
            onPressed: () {
              Get.back();
              NavigationUtils().callRfidScreen();
            },
            asset: Assets.iconsMenuRfidTag,
          ),
          _DrawerItem(
            title: LocaleKeys.support,
            onPressed: () {
              Get.back();
              NavigationUtils().callSupportPage();
            },
            asset: Assets.iconsMenuSupport,
          ),
          const Divider(),
          _DrawerItem(
            title: LocaleKeys.aboutUs,
            onPressed: () {
              Get.back();
              NavigationUtils().callAboutUsPage();
            },
            asset: Assets.iconsMenuAboutus,
          ),
          _DrawerItem(
            title: LocaleKeys.logout,
            onPressed: () => NavigationUtils().callLogout(),
            asset: Assets.iconsMenuLogout,
          ),
          const SizedBox(height: 30),
          const Image(
            image: AssetImage(Assets.logoLogo),
            height: 76,
          ),
        ],
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    super.key,
    required this.title,
    required this.onPressed,
    required this.asset,
  });

  final String title;
  final GestureTapCallback onPressed;
  final String asset;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: SvgImageUtils().showSvgFromAsset(asset),
      horizontalTitleGap: 0,
      title: Text(translate(title)),
      onTap: onPressed,
    );
  }
}
