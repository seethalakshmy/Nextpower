import 'package:get/get.dart';
import 'package:project/presentation/rfid.tag.list/providers/rfid_tag_list_provider.dart';

import '../rfid_tag_list_model.dart';

class RfidTagListController extends GetxController {
  final isLoading = true.obs;
  List<RfidItem> rfidList = [];
  final isNameEditable = false.obs;

  @override
  void onInit() {
    RfidTagListProvider().getRfidTagList().then((value) {
      rfidList = value?.rfidList ?? [];
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