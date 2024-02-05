import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/name_widget.dart';

import 'controllers/my_vehicles_add_edit.controller.dart';

class MyVehiclesAddEditScreen extends GetView<MyVehiclesAddEditController> {
  const MyVehiclesAddEditScreen({Key? key}) : super(key: key);

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
                    Image.asset(
                      Assets.iconsMyVehicleCar,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    CustomCardView(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            CommonTextFieldWidget(
                                initialValue: controller.vehicle.vehicleNumber,
                                title:
                                    "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.number).toLowerCase()}",
                                onChanged: (value) {
                                  controller.validation();
                                  controller.vehicle.vehicleNumber =
                                      value ?? "";
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter vehicle number";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                                initialValue: controller.vehicle.vehicleMake,
                                title:
                                    "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.make).toLowerCase()}",
                                onChanged: (value) {
                                  controller.validation();
                                  controller.vehicle.vehicleMake = value ?? "";
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter vehicle make";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 10),
                            CommonTextFieldWidget(
                                initialValue: controller.vehicle.vehicleModel,
                                title:
                                    "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.model).toLowerCase()}",
                                onChanged: (value) {
                                  controller.validation();
                                  controller.vehicle.vehicleModel = value ?? "";
                                },
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Enter vehicle model";
                                  }
                                  return null;
                                }),
                            const SizedBox(height: 30),
                            Obx(() => RoundedRectangleButton(
                                enable: !controller.buttonDisable.value,
                                isLoading: controller.buttonLoading.value,
                                onPressed: () async {
                                  if(controller.validation()){
                                    controller.addVehicle();
                                  }
                                },
                                text: translate(LocaleKeys.done)))
                          ],
                        )),
                  ],
                ),
              )));
  }
}
