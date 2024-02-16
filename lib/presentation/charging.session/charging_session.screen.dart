import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/list_title_widget.dart';
import 'package:project/presentation/charging.session/widgets/charging_option_section.dart';
import 'package:project/presentation/station.details/widgets/charging_power_status_widget.dart';
import 'package:project/presentation/station.details/widgets/title_subtitle_column_row.dart';
import 'controllers/charging_session.controller.dart';

class ChargingSessionScreen extends GetView<ChargingSessionController> {
  const ChargingSessionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: CustomAppbar(
            title: controller.isLoading.value
                ? ""
                : controller.chargingSession?.chargingSession?.stationName ?? ""),
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
                            ListTitleWidget(
                                title: controller.chargingSession?.chargingSession?.chargingPointName ??
                                    ""),
                            const SizedBox(height: 10),
                            ChargingPowerStatusWidget(
                                connectorPower:
                                    "${controller.chargingSession?.chargingSession?.pricing?.power  ?? ""} ",//${translate(LocaleKeys.kw)
                                connectorStatus:
                                controller.chargingSession?.chargingSession?.status  ?? ""),
                            const SizedBox(height: 10),
                            TitleSubtitleColumnRowWidget(
                              title:
                                  controller.chargingSession?.chargingSession?.connectorName  ?? "",
                              subtitle:
                              controller.chargingSession?.chargingSession?.connectorType ??
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
        ListTitleWidget(title: translate(LocaleKeys.pricing)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.power),
                subtitle: controller.chargingSession?.chargingSession?.pricing?.power ?? "",
                showAsColumn: true,
              ),
            ),
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.type),
                subtitle: controller.chargingSession?.chargingSession?.pricing?.type ?? "",
                showAsColumn: true,
              ),
            ),
            Expanded(
              child: TitleSubtitleColumnRowWidget(
                title: translate(LocaleKeys.tariff),
                subtitle: controller.chargingSession?.chargingSession?.pricing?.tariff ?? "",
                showAsColumn: true,
              ),
            )
          ],
        ),
      ],
    );
  }
}

class _CustomDivider extends StatelessWidget {
  const _CustomDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SizedBox(height: 10),
        Divider(),
        SizedBox(height: 10),
      ],
    );
  }
}