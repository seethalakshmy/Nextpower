import 'package:flutter/material.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

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
          DrawerHeader(
            padding: const EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Align(
                    alignment: Alignment.topRight,
                    child: IconButton(
                        onPressed: NavigationUtils().goBack,
                        icon: const Icon(Icons.close))),
                SizedBox(
                    width: 50,
                    height: 50,
                    child: SvgImageUtils()
                        .showSvgFromAsset(Assets.iconsMenuProfile)),
                const SizedBox(height: 10),
                const Text('John Doe'),
                const SizedBox(height: 5),
                const SubtitleWidget(
                  subtitle: '+91 1234567890',
                  fontWeight: FontWeight.w400,
                ),
              ],
            ),
          ),
          _DrawerItem(
            title: LocaleKeys.station,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuStation,
          ),
          _DrawerItem(
            title: LocaleKeys.profile,
            onPressed: () => NavigationUtils().callProfile(),
            asset: Assets.iconsMenuProfile,
          ),
          _DrawerItem(
            title: LocaleKeys.wallet,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuWallet,
          ),
          _DrawerItem(
            title: LocaleKeys.chargingHistory,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuChargingHistory,
          ),
          _DrawerItem(
            title: LocaleKeys.myVehicles,
            onPressed: () => NavigationUtils().callMyVehicles(),
            asset: Assets.iconsCarIcon,
          ),
          _DrawerItem(
            title: LocaleKeys.myAddress,
            onPressed: () => NavigationUtils().callMyAddress(),
            asset: Assets.iconsMenuMyAddress,
          ),
          _DrawerItem(
            title: LocaleKeys.rfidTag,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuRfidTag,
          ),
          _DrawerItem(
            title: LocaleKeys.support,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuSupport,
          ),
          const Divider(),
          _DrawerItem(
            title: LocaleKeys.aboutUs,
            onPressed: () => NavigationUtils().callScreenYetToBeDone(),
            asset: Assets.iconsMenuAboutus,
          ),
          _DrawerItem(
            title: LocaleKeys.logout,
            onPressed: () => NavigationUtils().callLogout(),
            asset: Assets.iconsMenuLogout,
          ),
          const SizedBox(height: 30),
          SvgImageUtils().showSvgFromAsset(Assets.iconsMenuNextPowerLogo)
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
      title: Text(translate(title)),
      onTap: onPressed,
    );
  }
}