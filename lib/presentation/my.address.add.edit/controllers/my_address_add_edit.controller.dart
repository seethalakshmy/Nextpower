import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/dal/daos/country_list_model.dart';
import 'package:project/infrastructure/dal/daos/providers/country_list_provider.dart';
import 'package:project/infrastructure/dal/daos/providers/state_list_provider.dart';
import 'package:project/infrastructure/dal/daos/state_list_model.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/my.address/address_list_model.dart';
import 'package:project/presentation/my.address/providers/address_list_provider.dart';

class MyAddressAddEditController extends GetxController {
  final isLoading = true.obs;
  Address address = Address();
  final formKey = GlobalKey<FormState>();
  int addressId = 0;

  List<Countries> countries = [];
  RxList<States> states = <States>[].obs;
  Countries? selectedCountry;
  States? selectedState;

  @override
  void onInit() {
    addressId = int.parse(Get.parameters[ParamName.addressId].toString());
    CountryListProvider().getCountryList().then((value) {
      countries = value?.countries ?? [];
      if (addressId != 0) {
        AddressListProvider().getAddressList().then((value) {
          address = value?.address
                  ?.singleWhere((element) => element.addressId == addressId) ??
              Address();
          selectedCountry = countries
              .singleWhere((element) => element.id == address.countryId);
          setStateList(selectedCountry?.id ?? 0);
          isLoading(false);
          print("Address:${jsonEncode(address)}");
        });
      } else {
        isLoading(false);
      }
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

  void setStateList(int id) {
    StateListProvider().getStateList(selectedCountry?.id ?? 0).then((value) {
      states.value = value?.states ?? [];
      if (addressId != 0) {
        selectedState =
            states.singleWhere((element) => element.id == selectedCountry?.id);
      }
    });
  }
}