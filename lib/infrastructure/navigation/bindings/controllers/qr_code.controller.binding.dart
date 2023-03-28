import 'package:get/get.dart';

import '../../../../presentation/qr.code/controllers/qr_code.controller.dart';

class QrCodeControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<QrCodeController>(
      () => QrCodeController(),
    );
  }
}
