import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/address/AddressResponse.dart';
import 'package:project/infrastructure/dal/providers/address/address_provider.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';

import '../../../infrastructure/dal/models/countries/CountryResponse.dart';
import '../../../infrastructure/dal/models/states/StatesResponse.dart';

class MyAddressController extends GetxController {
  //TODO: Implement MyAddressController

  final isLoading = false.obs;
  RxList<SavedAddress> address = RxList.empty(growable: true);
  RxList<Country> countries = RxList.empty(growable: true);
  RxList<CountryState> states = <CountryState>[].obs;
  RxString userCountryItem = "".obs;
  RxString userStateItem = "".obs;

  @override
  void onInit() async {
    isLoading(true);
    await getCountries();
    await setStateList(1);
    await getAddress();
    super.onInit();
  }

  Future getAddress() async {
    address.clear();
    isLoading(true);
    AddressProvider().getAddress().then((value) {
      AddressResponse response = value;
      if (response.status ?? false) {
        if (response.savedAddress?.id != null) {
          address.add(response.savedAddress ?? SavedAddress());
          for (var country in countries) {
            if (country.id == address.value[0].countryId) {
              userCountryItem.value = country.name ?? "";
              break;
            }
          }
          for (var state in states) {
            if (state.id == address.value[0].countryId) {
              userStateItem.value = state.name ?? "";
              break;
            }
          }
        }
        isLoading(false);
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void moveAddEditScreen(int id) {
    NavigationUtils().callMyAddressAddEditPage(id).then((value) {
      if (value) {
        getAddress();
      }
    });
  }

  Future getCountries() async {
    AddressProvider().getCountries().then((response) {
      if (response.status ?? false) {
        countries.value = response.countries ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  Future setStateList(int id) async {
    AddressProvider().getStates(countryId: id.toString()).then((response) {
      if (response.status ?? false) {
        states.value = response.states ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }
}
