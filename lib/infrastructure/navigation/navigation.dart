import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../../config.dart';
import '../../presentation/screens.dart';
import 'bindings/controllers/controllers_bindings.dart';
import 'routes.dart';

class EnvironmentsBadge extends StatelessWidget {
  final Widget child;

  const EnvironmentsBadge({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    var env = ConfigEnvironments.getEnvironments()['env'];
    return env != Environments.PRODUCTION
        ? Banner(
            location: BannerLocation.topStart,
            message: env!,
            color: env == Environments.QAS ? Colors.blue : Colors.purple,
            child: child,
          )
        : SizedBox(child: child);
  }
}

class Nav {
  static List<GetPage> routes = [
    GetPage(
      name: Routes.HOME,
      page: () => const HomeScreen(),
      binding: HomeControllerBinding(),
    ),
    GetPage(
      name: Routes.SPLASH_SCREEN,
      page: () => const SplashScreenScreen(),
      binding: SplashScreenControllerBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => const LoginScreen(),
      binding: LoginControllerBinding(),
    ),
    GetPage(
      name: Routes.OTP,
      page: () => const OtpScreen(),
      binding: OtpControllerBinding(),
    ),
    GetPage(
      name: Routes.REGISTRATION,
      page: () => const RegistrationScreen(),
      binding: RegistrationControllerBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => const ProfileScreen(),
      binding: ProfileControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_VEHICLES,
      page: () => const MyVehiclesScreen(),
      binding: MyVehiclesControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_VEHICLES_ADD_EDIT,
      page: () => const MyVehiclesAddEditScreen(),
      binding: MyVehiclesAddEditControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_ADDRESS,
      page: () => const MyAddressScreen(),
      binding: MyAddressControllerBinding(),
    ),
    GetPage(
      name: Routes.MY_ADDRESS_ADD_EDIT,
      page: () => const MyAddressAddEditScreen(),
      binding: MyAddressAddEditControllerBinding(),
    ),
    GetPage(
      name: Routes.STATION_LIST,
      page: () => const StationListScreen(),
      binding: StationListControllerBinding(),
    ),
    GetPage(
      name: Routes.STATION_DETAILS,
      page: () => const StationDetailsScreen(),
      binding: StationDetailsControllerBinding(),
    ),
    GetPage(
      name: Routes.CHARGING_SESSION,
      page: () => const ChargingSessionScreen(),
      binding: ChargingSessionControllerBinding(),
    ),
    GetPage(
      name: Routes.QR_CODE,
      page: () => QrCodeScreen(),
      binding: QrCodeControllerBinding(),
    ),
    GetPage(
      name: Routes.USAGE_HISTORY_DETAILS,
      page: () => const UsageHistoryDetailsScreen(),
      binding: UsageHistoryDetailsControllerBinding(),
    ),
    GetPage(
      name: Routes.RFID_TAG_LIST,
      page: () => const RfidTagListScreen(),
      binding: RfidTagListControllerBinding(),
    ),
    GetPage(
      name: Routes.WALLET_LIST,
      page: () => const WalletListScreen(),
      binding: WalletListControllerBinding(),
    ),
  ];
}
