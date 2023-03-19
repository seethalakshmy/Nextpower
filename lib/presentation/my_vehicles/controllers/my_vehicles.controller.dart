import 'package:get/get.dart';
import 'package:project/presentation/my_vehicles/models/vehicles_list_model.dart';
import 'package:project/presentation/my_vehicles/providers/vehicles_list_provider.dart';

class MyVehiclesController extends GetxController {
  RxBool isLoading = false.obs;

  List<Vehicles> vehiclesList = [];

  @override
  void onInit() {
    isLoading(true);
    VehiclesListProvider().getVehiclesList().then((value) {
      vehiclesList = value?.vehicles ?? [];
      isLoading(false);
    });
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