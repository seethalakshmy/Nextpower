
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/base/CommonResponse.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/dal/models/countries/country_list_model.dart';
import 'package:project/infrastructure/dal/models/states/StatesResponse.dart';
import 'package:project/infrastructure/dal/providers/address/address_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/dal/models/address/address_request_model.dart';

class MyAddressAddEditController extends GetxController {
  final isLoading = false.obs;
  RxBool countriesLoading = false.obs;
  Address address = Address();
  final formKey = GlobalKey<FormState>();
  int addressId = 0;

  RxList<Country> countries = RxList.empty(growable: true);
  RxList<CountryState> states = <CountryState>[].obs;
  Countries? selectedCountry;
  CountryState? selectedState;

  @override
  void onInit() {
    addressId = int.parse(Get.parameters[ParamName.addressId].toString());
    // CountryListProvider().getCountryList().then((value) {
    //   countries = value?.countries ?? [];
    //   if (addressId != 0) {
    //     AddressListProvider().getAddressList().then((value) {
    //       address = value?.address
    //               ?.singleWhere((element) => element.addressId == addressId) ??
    //           Address();
    //       selectedCountry = countries
    //           .singleWhere((element) => element.id == address.countryId);
    //       setStateList(selectedCountry?.id ?? 0);
    //       isLoading(false);
    //       print("Address:${jsonEncode(address)}");
    //     });
    //   } else {
    //     isLoading(false);
    //   }
    // });

    getCountries();

    super.onInit();
  }

  void getCountries() {
    countriesLoading(true);
    AddressProvider().getCountries().then((response) {
      countriesLoading(false);
      if (response.status ?? false) {
        countries.value = response.countries ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void addAddress() {
    isLoading(true);
    AddressProvider().addAddress(
        addressline2: address.addressLine2,
        addressline1: address.addressLine1,
        city: address.city,
        stateId: address.stateId.toString(),
        postalCode: address.postalCode,
        countryId: address.countryId.toString(),
      companyName: address.companyName,
      gstNo: address.gstNo
    ).then((value) {
      isLoading(false);
      CommonResponse response = value;
      if (response.status ?? false) {
        Get.back(result: true);
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void setStateList(int id) {
    AddressProvider().getStates(countryId: id.toString()).then((response) {
      countriesLoading(false);
      if (response.status ?? false) {
        states.value = response.states ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }
}