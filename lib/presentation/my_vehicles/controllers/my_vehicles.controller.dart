import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleListResponse.dart';
import 'package:project/infrastructure/dal/providers/vehicle/vehicle_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/views/custom_alert_view.dart';

class MyVehiclesController extends GetxController {
  RxBool isLoading = false.obs;

  RxList<Vehicles> vehiclesList = RxList<Vehicles>.empty(growable: true);

  @override
  void onInit() {
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

  void deleteItem(int id) {
    VehicleProvider().deleteVehicleItem(vehicleId: id.toString()).then((response) {
      if (response.status ?? false) {
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.deleted.tr, response.message ?? "");
        getVehicleList();
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void showDeleteAlert(int id){
    Get.dialog(
      CustomAlertView(
        title: translate(LocaleKeys.do_you_really_want_to_delete),
        onPositiveTap: (){
          Get.back();
          deleteItem(id);
        },
        positiveButtonRightAlign: true,
      ),
    );
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