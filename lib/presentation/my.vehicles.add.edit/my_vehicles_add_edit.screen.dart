import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/name_widget.dart';
import 'package:project/presentation/my.vehicles.add.edit/widgets/searchable_dropdown.dart';

import 'controllers/my_vehicles_add_edit.controller.dart';

class MyVehiclesAddEditScreen extends GetView<MyVehiclesAddEditController> {
  const MyVehiclesAddEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: const CustomAppbar(title: ''),
        body: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : Form(
                key: controller.formKey,
                child: SingleChildScrollView(
                  child: Column(
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
                                  initialValue:
                                      controller.vehicle.vehicleNumber.toUpperCase(),
                                  title:
                                      "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.number).toLowerCase()}",
                                  onChanged: (value) {
                                    controller.vehicle.vehicleNumber =
                                        value ?? "";
                                  },
                                  validator: (value) {
                                    return null;
                                  }),
                              const SizedBox(height: 10),
                              SearchableDropdown(
                                title:
                                    "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.make).toLowerCase()}",
                                controller: controller,
                                onSelected: (item) {
                                  controller.makeId = "${item.id ?? 0}";
                                  controller.getVehicleModelList();
                                },
                                fromMakers: true,
                              ),
                              const SizedBox(height: 10),
                              SearchableDropdown(
                                title:
                                    "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.model).toLowerCase()}",
                                controller: controller,
                                fromMakers: false,
                                onSelectedModel: (ModelsItem item) {
                                  controller.modelId = "${item.id ?? 0}";
                                },
                              ),
                              const SizedBox(height: 30),
                              RoundedRectangleButton(
                                  enable: controller.buttonEnable.value,
                                  isLoading: controller.buttonLoading.value,
                                  onPressed: () async {
                                    if (controller.validation()) {
                                      if (controller.vehicleId != 0) {
                                        controller.updateVehicle();
                                      } else {
                                        controller.addVehicle();
                                      }
                                    }
                                  },
                                  text: translate(LocaleKeys.done))
                            ],
                          )),
                    ],
                  ),
                ),
              )));
  }
}
