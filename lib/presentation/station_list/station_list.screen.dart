import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';

import 'controllers/station_list.controller.dart';

class StationListScreen extends GetView<StationListController> {
  const StationListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Stations'),
        centerTitle: true,
      ),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : ListView.builder(
              itemCount: controller.stationList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    NavigationUtils().callStationDetails();
                  },
                  onLongPress: () {
                    Get.dialog(Text("test"));
                  },
                  child: Card(
                    margin: const EdgeInsets.all(10),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        controller.stationList[index].stationName ?? "",
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                );
              })),
    );
  }
}