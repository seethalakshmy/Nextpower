import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';

import 'controllers/my_vehicles.controller.dart';

class MyVehiclesScreen extends GetView<MyVehiclesController> {
  const MyVehiclesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: NavigationUtils().goBack,
      child: Scaffold(
          appBar: CustomAppbar(
            title: translate(LocaleKeys.myVehicles),
            centerTitle: false,
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              NavigationUtils().callMyVehiclesAddEditPage(0);
            },
            backgroundColor: AppColors.primaryGreen,
            child: const Icon(Icons.add),
          ),
          body: Obx(() => controller.isLoading.value
              ? const LoadingWidget()
              : Column(
                  children: [
                    const SizedBox(height: 10),
                    Image.asset(
                      Assets.iconsMyVehicleCar,
                      height: 150,
                      width: 150,
                    ),
                    const SizedBox(height: 10),
                    _ContentView(
                      controller: controller,
                    ),
                  ],
                ))),
    );
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    super.key,
    required this.controller,
  });

  final MyVehiclesController controller;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: CustomCardView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.vehiclesList.length,
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Column(
                children: [
                  _VehicleNumberAndEditWidget(
                      controller: controller, index: index),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _MakeModelWidget(
                        title: translate(LocaleKeys.make),
                        text: controller.vehiclesList[index].vehicleMake ?? "",
                      ),
                      _MakeModelWidget(
                        title: translate(LocaleKeys.model),
                        text: controller.vehiclesList[index].vehicleModel ?? "",
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Divider(),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

class _VehicleNumberAndEditWidget extends StatelessWidget {
  const _VehicleNumberAndEditWidget({
    super.key,
    required this.controller,
    required this.index,
  });

  final MyVehiclesController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Wrap(
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            SvgImageUtils().showSvgFromAsset(Assets.iconsCarIcon),
            const SizedBox(width: 10),
            Text(
              controller.vehiclesList[index].vehicleNumber ?? "",
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
        GestureDetector(
          onTap: () {
            NavigationUtils().callMyVehiclesAddEditPage(
                controller.vehiclesList[index].vehicleId ?? 0);
          },
          child: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit),
        ),
      ],
    );
  }
}

class _MakeModelWidget extends StatelessWidget {
  const _MakeModelWidget({
    super.key,
    required this.title,
    required this.text,
  });

  final String title;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: AppColors.descriptionTextColor),
          ),
          const SizedBox(height: 5),
          Text(
            text,
          )
        ],
      ),
    );
  }
}