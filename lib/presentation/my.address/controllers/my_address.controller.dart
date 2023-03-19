import 'package:get/get.dart';
import 'package:project/presentation/my.address/address_list_model.dart';
import 'package:project/presentation/my.address/providers/address_list_provider.dart';

class MyAddressController extends GetxController {
  //TODO: Implement MyAddressController

  final isLoading = false.obs;

  List<Address> address = [];

  @override
  void onInit() {
    isLoading(true);
    AddressListProvider().getAddressList().then((value) {
      address = value?.address ?? [];
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