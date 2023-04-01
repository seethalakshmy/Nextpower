import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/station.details/widgets/station_brief_details_widget.dart';

import 'controllers/station_list.controller.dart';

class StationListScreen extends GetView<StationListController> {
  const StationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: translate(LocaleKeys.stations),
      ),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : ListView.builder(
              itemCount: controller.stationList.length,
              itemBuilder: (context, index) {
                var station = controller.stationList[index];
                return GestureDetector(
                  onTap: () {
                    NavigationUtils()
                        .callStationDetails(station.stationId ?? 0);
                  },
                  onLongPress: () {
                    Get.dialog(StationBriefDetailsWidget(station));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        station.stationName ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}