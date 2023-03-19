import 'package:get/get.dart';

import '../../../../presentation/my.address/controllers/my_address.controller.dart';

class MyAddressControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAddressController>(
      () => MyAddressController(),
    );
  }
}
