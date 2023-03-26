import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/charging.session/widgets/charging_option_section.dart';
import 'package:project/presentation/station.details/widgets/station_status_widget.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';

import 'controllers/charging_session.controller.dart';

class ChargingSessionScreen extends GetView<ChargingSessionController> {
  const ChargingSessionScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppbar(
            title: controller.isLoading.value
                ? ""
                : controller.sessionDetails!.stationName ?? ""),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : SingleChildScrollView(
                  child: CustomCardView(
                      margin: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      padding: const EdgeInsets.only(
                          top: 20, left: 20, right: 20, bottom: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _TitleWidget(
                                title: controller
                                        .sessionDetails!.chargingPointName ??
                                    ""),
                            const SizedBox(height: 10),
                            Wrap(
                              crossAxisAlignment: WrapCrossAlignment.center,
                              alignment: WrapAlignment.start,
                              children: [
                                SvgImageUtils().showSvgFromAsset(
                                    Assets.iconsMenuStation,
                                    width: 20,
                                    height: 20),
                                const SizedBox(width: 5),
                                SubtitleWidget(
                                  subtitle:
                                      "${controller.sessionDetails!.kw ?? ""} ${translate(LocaleKeys.kw)}",
                                  fontSize: 16,
                                ),
                                const SizedBox(width: 15),
                                StationStatusWidget(
                                    stationStatus:
                                        controller.sessionDetails!.status ?? "")
                              ],
                            ),
                            const SizedBox(height: 10),
                            TitleSubtitleColumnRowWidget(
                              title:
                                  "${controller.sessionDetails?.connectorName ?? ""}:",
                              subtitle:
                                  controller.sessionDetails?.connectorType ??
                                      "",
                              showAsColumn: false,
                            ),
                            const _CustomDivider(),
                            const _PricingSection(),
                            const _CustomDivider(),
                            const ChargingOptionsSection(),
                            const SizedBox(height: 30),
                            RoundedRectangleButton(
                                onPressed: () {
                                  NavigationUtils().callScreenYetToBeDone();
                                },
                                height: 50,
                                padding: EdgeInsets.zero,
                                text: translate(LocaleKeys.startCharging)),
                            const SizedBox(height: 30),
                          ],
                        ),
                      )),
                ),
        ),
      ),
    );
  }
}

class _PricingSection extends GetView<ChargingSessionController> {
  const _PricingSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TitleWidget(title: translate(LocaleKeys.pricing)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.power),
                subtitle: controller.sessionDetails?.pricing?.power ?? "",
                showAsColumn: true,
              ),
            ),
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.type),
                subtitle: controller.sessionDetails?.pricing?.type ?? "",
                showAsColumn: true,
              ),
            ),
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.tariff),
                subtitle: controller.sessionDetails?.pricing?.tariff ?? "",
                showAsColumn: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget({
    super.key,
    required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return TitleWidget(
      title: title,
      fontWeight: FontWeight.w600,
      fontSize: 18,
      color: AppColors.labelColor2,
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}