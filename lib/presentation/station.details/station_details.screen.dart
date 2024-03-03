import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/station.details/widgets/connectors_list.dart';
import 'package:project/presentation/station.details/widgets/overview_widget.dart';

import 'controllers/station_details.controller.dart';
import 'widgets/header_view.dart';

class StationDetailsScreen extends GetView<StationDetailsController> {
  const StationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: '',
        elevation: 0.0,
      ),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : controller.stationDetails.value.stationId == null
              ? EmptyListView(
                  subTitle: translate(LocaleKeys.noSuchStationsFound),
                  title: translate(LocaleKeys.sorry))
              : RefreshIndicator(
                  onRefresh: () async {
                    if (controller.isSelectedConnectorView.value) {
                      controller.getConnectors();
                      return Future<void>.delayed(const Duration(seconds: 3));
                    }
                    return;
                  },
                  child: ListView(
                    children: [
                      const HeaderView(),
                      Obx(() => controller.isSelectedConnectorView.value
                          ? const ConnectorsListWidget()
                          : const OverviewWidget()),
                    ],
                  ),
                )),
    );
  }
}
