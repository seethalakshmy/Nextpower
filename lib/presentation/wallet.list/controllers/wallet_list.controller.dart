import 'package:get/get.dart';
import 'package:project/presentation/wallet.list/providers/wallet_list_provider.dart';
import 'package:project/presentation/wallet.list/wallet_list_model.dart';

class WalletListController extends GetxController {

  final isLoading = true.obs;
  List<WalletHistory> list = [];
  
  @override
  void onInit() {
    WalletListProvider().getWalletList().then((value) {
      list = value?.walletHistory ?? [];
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