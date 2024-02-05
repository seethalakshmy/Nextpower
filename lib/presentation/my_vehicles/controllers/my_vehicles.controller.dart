import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleListResponse.dart';
import 'package:project/infrastructure/dal/providers/vehicle/vehicle_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

class MyVehiclesController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Vehicles> vehiclesList = RxList<Vehicles>.empty(growable: true);

  @override
  void onInit() {
    // isLoading(true);
    // VehiclesListProvider().getVehiclesList().then((value) {
    //   vehiclesList = value?.vehicles ?? [];
    //   isLoading(false);
    // });
    getVehicleList();
    super.onInit();
  }

  void getVehicleList() {
    isLoading(true);
    VehicleProvider().getVehicleList().then((response) {
      isLoading(false);
      if (response.status ?? false) {
        vehiclesList.value = response.vehicles ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void moveAddEditScreen(int id) {
    NavigationUtils().callMyVehiclesAddEditPage(id).then((value) {
      if(value){
        //call get api
        getVehicleList();
      }
    });
  }
}