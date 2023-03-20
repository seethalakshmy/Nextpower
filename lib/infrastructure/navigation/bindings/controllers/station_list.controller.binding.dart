import 'package:get/get.dart';

import '../../../../presentation/station_list/controllers/station_list.controller.dart';

class StationListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StationListController>(
      () => StationListController(),
    );
  }
}
