import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/dal/models/countries/state_list_model.dart';
import 'package:project/infrastructure/dal/models/states/StatesResponse.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/dropdowns/custom_dropdown.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/name_widget.dart';

import '../../generated/assets.dart';
import 'controllers/my_address_add_edit_controller.dart';

class MyAddressAddEditScreen extends GetView<MyAddressAddEditController> {
  const MyAddressAddEditScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(title: ''),
      body: Obx(() => controller.isLoading.value
          ? const LoadingWidget()
          : Form(
              key: controller.formKey,
              child: ListView(
                children: [
                  const SizedBox(height: 10),
                  SvgImageUtils().showSvgFromAsset(
                      Assets.iconsMyAddressLocation,
                      width: 120,
                      height: 120),
                  const SizedBox(height: 10),
                  CustomCardView(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CommonTextFieldWidget(
                              initialValue: controller.address.addressLine1,
                              title: translate(LocaleKeys.addressLine1),
                              onChanged: (value) {
                                controller.address.addressLine1 = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${translate(LocaleKeys.addressLine1)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                              initialValue: controller.address.addressLine2,
                              title: translate(LocaleKeys.addressLine2),
                              onChanged: (value) {
                                controller.address.addressLine2 = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${translate(LocaleKeys.addressLine2)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                              initialValue: controller.address.city,
                              title: translate(LocaleKeys.city),
                              onChanged: (value) {
                                controller.address.city = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${translate(LocaleKeys.city)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          CustomDropdownWidget(
                            initialValue: controller.selectedCountry,
                            fieldTitle: translate(LocaleKeys.country),
                            list: controller.countries.map((Country items) {
                              return DropdownMenuItem(
                                value: items,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(items.name ?? ""),
                                ),
                              );
                            }).toList(),
                            onSaved: (dynamic countries) {},
                            onChanged: (Country countries) {
                              controller.address.countryId = countries.id ?? 0;
                              controller.setStateList(countries.id ?? 0);
                            },
                            customValidator: (dynamic country) {
                              if (country == null) {
                                return "${translate(LocaleKeys.country)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                              } else {
                                return null;
                              }
                            },
                          ),
                          const SizedBox(height: 10),
                          Obx(() => CustomDropdownWidget(
                                initialValue: controller.selectedState,
                                fieldTitle: translate(LocaleKeys.state),
                                list: controller.states.map((CountryState items) {
                                  return DropdownMenuItem(
                                    value: items,
                                    child: Padding(
                                      padding: EdgeInsets.only(left: 8.0),
                                      child: Text(items.name ?? ""),
                                    ),
                                  );
                                }).toList(),
                                onSaved: (dynamic countries) {},
                                onChanged: (CountryState states) {
                                  debugPrint("state:${states.id}");
                                  controller.address.stateId = states.id ?? 0;
                                },
                                customValidator: (dynamic states) {
                                  if (states == null) {
                                    return "${translate(LocaleKeys.state)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                  } else {
                                    return null;
                                  }
                                },
                              )),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                              initialValue: controller.address.postalCode,
                              title: translate(LocaleKeys.postalCode),
                              onChanged: (value) {
                                controller.address.postalCode = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${translate(LocaleKeys.postalCode)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                              initialValue: controller.address.companyName,
                              title: translate(LocaleKeys.company),
                              onChanged: (value) {
                                controller.address.companyName = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${translate(LocaleKeys.company)} ${translate(LocaleKeys.shouldntBeEmpty)}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 10),
                          CommonTextFieldWidget(
                              initialValue: controller.address.gstNo,
                              title: translate(LocaleKeys.gstNo),
                              onChanged: (value) {
                                controller.address.gstNo = value ?? "";
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return "${LocaleKeys.gstNo} ${LocaleKeys.shouldntBeEmpty}";
                                }
                                return null;
                              }),
                          const SizedBox(height: 30),
                          RoundedRectangleButton(
                              onPressed: () async {
                                controller.addAddress();
                              },
                              text: translate(LocaleKeys.done))
                        ],
                      )),
                  const SizedBox(height: 20),
                ],
              ),
            )),
    );
  }
}