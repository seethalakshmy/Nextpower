import 'package:get/get.dart';

import '../../../../presentation/login/controllers/login_controller.dart';

class LoginControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<LoginController>(
      () => LoginController(),
    );
  }
}
