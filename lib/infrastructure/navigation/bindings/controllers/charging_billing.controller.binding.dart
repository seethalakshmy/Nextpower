import 'package:get/get.dart';

import '../../../../presentation/charging.billing/controllers/charging_billing.controller.dart';

class ChargingBillingControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<ChargingBillingController>(
      () => ChargingBillingController(),
    );
  }
}
