import 'package:get/get.dart';

import '../../../../presentation/my_vehicles/controllers/my_vehicles.controller.dart';

class MyVehiclesControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MyVehiclesController>(
      () => MyVehiclesController(),
    );
  }
}
