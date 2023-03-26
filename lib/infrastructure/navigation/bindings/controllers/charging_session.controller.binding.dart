import 'package:get/get.dart';

import '../../../../presentation/charging.session/controllers/charging_session.controller.dart';

class ChargingSessionControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChargingSessionController>(
      () => ChargingSessionController(),
    );
  }
}
