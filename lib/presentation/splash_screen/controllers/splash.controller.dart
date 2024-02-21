import 'dart:async';
import 'dart:io';

import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project/infrastructure/views/alert_view_with_subtitle.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/version/version_detail_response_model.dart';
import '../../../infrastructure/dal/providers/home_stations/home_stations_provider.dart';
import '../../../infrastructure/navigation/navigation_utils.dart';

class SplashScreenController extends GetxController {
  Rx<VersionDetailResponseModel> versionDetail =
      VersionDetailResponseModel().obs;
  RxString versionName = "".obs;

  @override
  void onInit() async {
    super.onInit();
    await getVersionNumber();
  }

  @override
  void onReady() async {
    super.onReady();
    Future.delayed(const Duration(seconds: 3), () async {
      await getVersionDetails();
    });
  }

  @override
  void onClose() {
    super.onClose();
  }

  Future getVersionDetails() async {
    // isLoading(true);
    HomeStationsProvider().getVersionDetail().then((response) {
      if (response.status ?? false) {
        versionDetail.value = response;
        versionName.value = versionName.value.replaceAll(".", '');
        int currentVersion = int.parse(versionName.value);
        if (Platform.isAndroid) {
          String? message =
              versionDetail.value.appVersions?.android?.notes ?? "";
          String? versionString =
              versionDetail.value.appVersions?.android?.version ?? "";
          versionString = versionString.replaceAll(".", '');
          int newVersion = int.parse(versionString);
          validateVersion(currentVersion, newVersion, message, true);
        } else {
          String? message = versionDetail.value.appVersions?.ios?.notes ?? "";
          String? versionString =
              versionDetail.value.appVersions?.ios?.version ?? "";
          versionString = versionString.replaceAll(".", '');
          int newVersion = int.parse(versionString);
          validateVersion(currentVersion, newVersion, message, false);
        }
      } else {
        NavigationUtils().goFromSplash();
        print(response.message ?? "");
      }
    });
  }

  void validateVersion(
      int currentVersion, int newVersion, String message, bool isAndroid) {
    print("currentVersion === $currentVersion");
    print("newVersion === $newVersion");

    if (currentVersion < newVersion) {
      Get.dialog(AlertViewWithSubtitle(
        positiveButtonRightAlign: true,
        title: LocaleKeys.update_alert,
        subTitle: message,
        positiveText: LocaleKeys.upadate,
        onNegativeTap: () {
          NavigationUtils().goFromSplash();
        },
        onPositiveTap: () async {
          if (isAndroid) {
            Uri url = Uri.parse(
                "https://play.google.com/store/apps/details?id=com.ae.unidoc");
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          } else {
            Uri url = Uri.parse(
                "https://itunes.apple.com/in/app/unidoc-doctor-appointment/id1527263282?mt=8");
            if (await canLaunchUrl(url)) {
              await launchUrl(url);
            } else {
              throw 'Could not launch $url';
            }
          }
        },
      ));
    } else {
      NavigationUtils().goFromSplash();
    }
  }

  Future getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    versionName.value = packageInfo.version;
  }
}
