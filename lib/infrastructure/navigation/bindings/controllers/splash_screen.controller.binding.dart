import 'package:get/get.dart';

import '../../../../presentation/splash_screen/controllers/splash.controller.dart';

class SplashScreenControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SplashScreenController>(
          () => SplashScreenController(),
    );
  }
}