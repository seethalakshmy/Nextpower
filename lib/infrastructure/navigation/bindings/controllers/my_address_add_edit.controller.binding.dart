import 'package:get/get.dart';
import 'package:project/presentation/my_address_add_edit/controllers/my_address_add_edit_controller.dart';


class MyAddressAddEditControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyAddressAddEditController>(
      () => MyAddressAddEditController(),
    );
  }
}
