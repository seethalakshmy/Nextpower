import 'package:get/get.dart';

import '../../../../presentation/my.vehicles.add.edit/controllers/my_vehicles_add_edit.controller.dart';

class MyVehiclesAddEditControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVehiclesAddEditController>(
      () => MyVehiclesAddEditController(),
    );
  }
}
