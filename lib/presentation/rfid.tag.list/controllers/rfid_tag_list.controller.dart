import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/rfid/rfid_response.dart';
import '../../../infrastructure/dal/providers/rfid/rfidProvider.dart';
import '../../../infrastructure/utils/snackbar_utils.dart';

class RfidTagListController extends GetxController {
  final isLoading = true.obs;
  final isNameEditable = false.obs;
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




}