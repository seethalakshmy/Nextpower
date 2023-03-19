import 'package:get/get.dart';

import '../../../../presentation/my.address.add.edit/controllers/my_address_add_edit.controller.dart';

class MyAddressAddEditControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAddressAddEditController>(
      () => MyAddressAddEditController(),
    );
  }
}
