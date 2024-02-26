import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/usage_history/UsageHistoryDetailResponse.dart';
import 'package:project/infrastructure/dal/providers/usage_history/usage_history_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

class UsageHistoryDetailsController extends GetxController {
  int historyId = 0;

  Rxn<UsageHistory> details = Rxn(UsageHistory());
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    historyId = int.parse(Get.parameters[ParamName.historyId] ?? "0");

    getUsageHistoryDetails();
    super.onInit();
  }

  void getUsageHistoryDetails() {
    isLoading(true);
    UsageHistoryProvider()
        .getUsageHistoryDetails(id: historyId.toString())
        .then((value) {
      isLoading(false);
      UsageHistoryDetailResponse response = value;
      if (response.status ?? false) {
        details.value = response.usageHistory;
      } else {
        isLoading(false);
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }
}
