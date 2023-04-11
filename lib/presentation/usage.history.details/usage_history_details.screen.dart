import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/station.details/widgets/station_status_widget.dart';

import 'controllers/usage_history_details.controller.dart';

class UsageHistoryDetailsScreen extends GetView<UsageHistoryDetailsController> {
  const UsageHistoryDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: CustomAppbar(title: translate(LocaleKeys.history)),
        body: Obx(
          () => controller.isLoading.value
              ? const LoadingWidget()
              : controller.details != null
                  ? Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40.0, vertical: 20),
                      child: Column(
                        children: [
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                  child: Wrap(
                                children: [
                                  TitleWidget(
                                    title:
                                        "${translate(LocaleKeys.id).toUpperCase()}: ${controller.details?.id}",
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                  const SizedBox(width: 20),
                                  StationStatusWidget(
                                      stationStatus:
                                          controller.details?.status ?? ""),
                                ],
                              )),
                              Wrap(
                                crossAxisAlignment: WrapCrossAlignment.center,
                                alignment: WrapAlignment.center,
                                children: [
                                  const Icon(
                                    Icons.do_disturb,
                                    color: Colors.red,
                                    size: 16,
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    controller.details?.transactionStatus ?? "",
                                    style: const TextStyle(
                                        color: Colors.red, fontSize: 13),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _HistoryItem(
                            title: translate(LocaleKeys.totalCost),
                            value:
                                (controller.details?.totalCost ?? 0).toString(),
                          ),
                          _HistoryItem(
                            title: translate(LocaleKeys.totalUnit),
                            value:
                                (controller.details?.totalUnit ?? 0).toString(),
                          ),
                          _HistoryItem(
                            title: translate(LocaleKeys.connector),
                            value: controller.details?.connector ?? "",
                          ),
                          _HistoryItem(
                            title: translate(LocaleKeys.startTime),
                            value: controller.details?.startTime ?? "",
                          ),
                          _HistoryItem(
                            title: translate(LocaleKeys.endTime),
                            value: controller.details?.endTime ?? "",
                          ),
                        ],
                      ),
                    )
                  : EmptyListView(
                      subTitle: translate(
                          LocaleKeys.somethingWentWrongPleaseTryAgainLater),
                      title: translate(LocaleKeys.error)),
        ));
  }
}

class _HistoryItem extends GetView<UsageHistoryDetailsController> {
  const _HistoryItem({
    required this.title,
    required this.value,
  });

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SubtitleWidget(
                subtitle: title,
                fontSize: 15,
                fontWeight: FontWeight.w400,
                textColor: AppColors.iconColor,
              ),
            ),
            const SizedBox(width: 10),
            const Text(":"),
            const SizedBox(width: 10),
            Expanded(
              flex: 2,
              child: SubtitleWidget(
                subtitle: value,
                textColor: AppColors.btmTextColor,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10)
      ],
    );
  }
}