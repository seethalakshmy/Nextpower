import 'package:get/get.dart';

import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/Wallet/wallet_history_response_model.dart';
import '../../../infrastructure/dal/providers/wallet/wallet_history_provider.dart';
import '../../../infrastructure/utils/snackbar_utils.dart';

class WalletListController extends GetxController {
  final isLoading = false.obs;
  Rx<WalletHistoryResponseModel> walletHistory =
      WalletHistoryResponseModel().obs;

  @override
  void onInit() {
    getWalletHistory();
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

  void getWalletHistory() {
    isLoading(true);
    WalletHistoryProvider().getWalletHistory().then((value) {
      if (value.status != null && value.status == true) {
        walletHistory.value = value;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value.message ?? "");
      }
      isLoading(false);
    });
  }
}
