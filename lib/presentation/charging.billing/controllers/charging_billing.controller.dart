import 'package:get/get.dart';

import '../../../infrastructure/utils/param_name.dart';

class ChargingBillingController extends GetxController {
  int pageIndex = 0;

  @override
  void onInit() {
    pageIndex = int.parse(Get.parameters[ParamName.pageIndex] ?? "1");
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}