import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../infrastructure/utils/constants.dart';
import '../models/profile_model.dart';
import '../providers/profile_provider.dart';

class ProfileController extends GetxController {
  Rx<Profile> profile = Profile().obs;
  RxBool isLoading = false.obs;
  final formKey = GlobalKey<FormState>();

  @override
  void onInit() {
    isLoading(true);
    print('profileController init called');
    ProfileProvider().getProfile(0).then((value) {
      profile.value = value;
      isLoading(false);
    });
    super.onInit();
  }

  setCountryCode([String? value]) {
    profile.value.countryCode = value ?? AppConstants().countryCodeList.first;
    print(jsonEncode(profile));
  }

  @override
  void onReady() {
    print('profileController onready called');

    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}