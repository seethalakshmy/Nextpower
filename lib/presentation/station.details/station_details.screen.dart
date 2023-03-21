import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/empty_list_view.dart';
import 'package:project/presentation/station.details/widgets/connectors_list.dart';

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
          : controller.details == null
              ? EmptyListView(subTitle: 'No such station found', title: 'Oops')
              : ListView(
                  children: [
                    const HeaderView(),
                    Obx(() => controller.isSelectedConnectorView.value
                        ? const ConnectorsListWidget()
                        : Expanded(child: Container())),
                  ],
                )),
    );
  }
}