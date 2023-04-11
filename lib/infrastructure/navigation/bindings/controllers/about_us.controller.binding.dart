import 'package:get/get.dart';

import '../../../../presentation/about.us/controllers/about_us.controller.dart';

class AboutUsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AboutUsController>(
      () => AboutUsController(),
    );
  }
}
