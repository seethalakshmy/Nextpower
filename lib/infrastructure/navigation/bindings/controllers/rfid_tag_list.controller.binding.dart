import 'package:get/get.dart';

import '../../../../presentation/rfid.tag.list/controllers/rfid_tag_list.controller.dart';

class RfidTagListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<RfidTagListController>(
      () => RfidTagListController(),
    );
  }
}
