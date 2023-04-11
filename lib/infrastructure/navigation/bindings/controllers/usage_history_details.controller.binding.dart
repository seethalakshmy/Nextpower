import 'package:get/get.dart';

import '../../../../presentation/usage.history.details/controllers/usage_history_details.controller.dart';

class UsageHistoryDetailsControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<UsageHistoryDetailsController>(
      () => UsageHistoryDetailsController(),
    );
  }
}
