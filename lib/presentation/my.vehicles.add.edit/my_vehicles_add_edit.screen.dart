import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleMakersResponse.dart';
import 'package:project/infrastructure/dal/models/vehicles/VehicleModelsResponse.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/infrastructure/widgets/text_fields/name_widget.dart';
import 'package:project/presentation/my.vehicles.add.edit/widgets/vehicle_make_text_edit.dart';
import 'package:project/presentation/my.vehicles.add.edit/widgets/vehicle_model_text_edit.dart';

import '../../infrastructure/widgets/dropdowns/custom_dropdown.dart';
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
                                      controller.vehicle.vehicleNumber,
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
                              VehicleMakeTextEdit(
                                  initialText: controller.vehicle.vehicleMake,
                                  onTextChange: (value) {
                                    controller.makeId = "";
                                    controller.selectMakeId(value as String);
                                  },
                                  onSelected: (MakersItem value) {
                                    controller.makeId = "${value.id ?? 0}";
                                    controller.getVehicleModelList();
                                  },
                                  title:
                                      "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.make).toLowerCase()}",
                                  list: controller.makers.value),
                              const SizedBox(height: 10),
                              VehicleModelTextEdit(
                                  initialText: controller.vehicle.vehicleModel,
                                  onTextChange: (value) {
                                    controller.modelId = "";
                                    controller.selectModelId(value as String);
                                  },
                                  onSelected: (ModelsItem value) {
                                    controller.modelId = "${value.id ?? 0}";
                                  },
                                  title:
                                      "${translate(LocaleKeys.vehicle)} ${translate(LocaleKeys.model).toLowerCase()}",
                                  list: controller.models.value),
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
