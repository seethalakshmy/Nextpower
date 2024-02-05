import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/address/AddressResponse.dart';
import 'package:project/infrastructure/dal/providers/address/address_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

class MyAddressController extends GetxController {
  //TODO: Implement MyAddressController

  final isLoading = false.obs;

  RxList<SavedAddress> address = RxList.empty(growable: true);

  @override
  void onInit() {
    isLoading(true);

    getAddress();
    super.onInit();
  }

  void getAddress() {
    isLoading(true);
    AddressProvider().getAddress().then((value) {
      isLoading(false);
      AddressResponse response = value;
      if (response.status ?? false) {
        if (response.savedAddress?.id != null) {
          address.add(response.savedAddress ?? SavedAddress());
        }
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void moveAddEditScreen(int id) {
    NavigationUtils().callMyAddressAddEditPage(id).then((value) {
      if(value){
        getAddress();
      }
    });
  }
}
