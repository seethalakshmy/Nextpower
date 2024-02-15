import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/rfid/rfid_response.dart';
import '../../../infrastructure/dal/providers/rfid/rfidProvider.dart';
import '../../../infrastructure/utils/snackbar_utils.dart';

class RfidTagListController extends GetxController {
  final isLoading = true.obs;
  RxBool rfidStatus = false.obs;
  Rx <RfidResponse> rfidList = RfidResponse().obs;


  @override
  void onInit() {
    getRfidTagList();
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

  void getRfidTagList() {
    isLoading(true);
    RfidTagListProvider().getRfidTagList().then((value){
      if (value?.status != null){
        rfidList.value = value!;
      }else{
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value?.message ?? "");
      }
    });
    isLoading(false);

  }



  Future <bool> changeRfidNameStatus(String id,String tagName,bool rfidStatus) async{
    RfidTagListProvider().changeRfidNameStatus(id, tagName, rfidStatus ? "1":"0").then((value){
      if (value?.status != null&& value?.status == true){
        CustomSnackBar.showSuccessSnackBar(LocaleKeys.success, value?.message ?? "");
        return false;
      }else{
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value?.message ?? "");
        return false;
      }
    });
   return false;
  }

  bool getStatus(String? status) {
    if (status != null && status.toLowerCase() == "active") {
      return true;
    } else {
      return false;
    }
  }


}