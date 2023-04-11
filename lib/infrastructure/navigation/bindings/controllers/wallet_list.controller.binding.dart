import 'package:get/get.dart';

import '../../../../presentation/wallet.list/controllers/wallet_list.controller.dart';

class WalletListControllerBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<WalletListController>(
      () => WalletListController(),
    );
  }
}
