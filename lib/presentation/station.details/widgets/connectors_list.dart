import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_outline_button.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/station.details/controllers/station_details.controller.dart';
import 'package:project/presentation/station.details/widgets/station_status_widget.dart';

import '../../../infrastructure/widgets/text/title_widget.dart';
import '../models/station_details_model.dart';
import 'filter_view.dart';

class ConnectorsListWidget extends GetView<StationDetailsController> {
  const ConnectorsListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: (controller.details?.connectorsList != null &&
              controller.details!.connectorsList!.isNotEmpty)
          ? Column(
              children: [
                const FilterView(),
                ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount:
                        (controller.details?.connectorsList ?? []).length,
                    itemBuilder: (context, index) {
                      ConnectorsList connector =
                          (controller.details?.connectorsList![index])!;
                      return Card(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        elevation: 6,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              _ImageHeadingKWStatusWidget(index),
                              Row(
                                children: [
                                  Expanded(
                                    child: _TitleSubtitleColumn(
                                      title: connector.connectorName ?? "",
                                      subtitle: connector.connectorType ?? "",
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  Expanded(
                                    child: _TitleSubtitleColumn(
                                      title: translate(LocaleKeys.tariff),
                                      subtitle: connector.tariff ?? " ",
                                    ),
                                  ),
                                  IconButton(
                                      onPressed: () {
                                        controller.setIndexesData(index);
                                      },
                                      icon: Container(
                                          decoration: BoxDecoration(
                                              shape: BoxShape.circle,
                                              border: Border.all(
                                                  color:
                                                      AppColors.primaryBlue)),
                                          child: Obx(() => Icon(
                                                controller.openedIndexes
                                                        .contains(index)
                                                    ? Icons.keyboard_arrow_up
                                                    : Icons.keyboard_arrow_down,
                                                color: AppColors.primaryBlue,
                                              )))),
                                ],
                              ),
                              Obx(
                                () => controller.openedIndexes.contains(index)
                                    ? Column(
                                        children: [
                                          const Divider(),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: RoundedRectangleButton(
                                                    onPressed: () {},
                                                    text: translate(
                                                        LocaleKeys.charge)),
                                              ),
                                              const SizedBox(width: 10),
                                              Expanded(
                                                child: RoundedOutlineButton(
                                                    onPressed: () {},
                                                    text: translate(
                                                        LocaleKeys.reserve)),
                                              ),
                                            ],
                                          )
                                        ],
                                      )
                                    : Container(),
                              )
                            ],
                          ),
                        ),
                      );
                    }),
              ],
            )
          : EmptyListView(subTitle: 'No connectors Found', title: "Sorry"),
    );
  }
}

class _TitleSubtitleColumn extends StatelessWidget {
  const _TitleSubtitleColumn({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SubtitleWidget(subtitle: title),
        SubtitleWidget(
          subtitle: subtitle,
          textColor: AppColors.subTitleTextColor2,
          fontWeight: FontWeight.w500,
        ),
      ],
    );
  }
}

class _ImageHeadingKWStatusWidget extends GetView<StationDetailsController> {
  const _ImageHeadingKWStatusWidget(
    this.index, {
    super.key,
  });

  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgImageUtils().showSvgFromAsset(Assets.iconsChargerIcon),
        Expanded(
          child: Padding(
            padding: const EdgeInsetsDirectional.only(start: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TitleWidget(
                      title: controller.details!.connectorsList![index]
                              .chargingPointName ??
                          "",
                      fontWeight: FontWeight.bold,
                    ),
                    // StationStatusWidget(
                    //     stationStatus: controller
                    //             .details!
                    //             .connectorsList![index]
                    //             .status ??
                    //         "")
                  ],
                ),
                const SizedBox(height: 10),
                Wrap(
                  crossAxisAlignment: WrapCrossAlignment.center,
                  alignment: WrapAlignment.start,
                  children: [
                    SvgImageUtils().showSvgFromAsset(Assets.iconsMenuStation,
                        width: 20, height: 20),
                    const SizedBox(width: 5),
                    SubtitleWidget(
                        subtitle:
                            "${controller.details!.connectorsList![index].kw ?? ""} ${translate(LocaleKeys.kw)}"),
                    const SizedBox(width: 15),
                    StationStatusWidget(
                        stationStatus:
                            controller.details!.connectorsList![index].status ??
                                "")
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }
}