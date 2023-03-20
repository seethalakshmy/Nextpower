import 'package:get/get.dart';

import '../../../../presentation/station.details/controllers/station_details.controller.dart';

class StationDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StationDetailsController>(
      () => StationDetailsController(),
    );
  }
}
