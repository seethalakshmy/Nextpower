import 'package:get/get.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/usage.history.details/providers/usage_history_details_provider.dart';

import '../models/usage_history_details_model.dart';

class UsageHistoryDetailsController extends GetxController {
  int historyId = 0;

  UsageHistoryDetails? details;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    historyId = int.parse(Get.parameters[ParamName.historyId] ?? "0");
    fetchUserDetails();
    super.onInit();
  }

  void fetchUserDetails() {
    UsageHistoryDetailsProvider()
        .getUsageHistoryDetails(historyId)
        .then((value) {
      details = value;
      isLoading(false);
    });
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