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

import '../empty_list_view.dart';
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
              controller.moveAddEditScreen(0);

            },
            backgroundColor: AppColors.primaryGreen,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(28)),
            child: const Icon(Icons.add,color: Colors.white,),
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
                    // const SizedBox(height: 10),
                    Expanded(
                      child: _ContentView(
                        controller: controller,
                      ),
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
    return CustomCardView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: Obx(() =>  controller.vehiclesList.isNotEmpty ? ListView.builder(
        shrinkWrap: true,
        itemCount: controller.vehiclesList.length,
        itemBuilder: (context, index) {
          return Container(
            height: 120,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
                border: Border(
                    bottom: BorderSide(
                        color: Colors.grey,
                        width: 0.2
                    )
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Container(
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
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 40,child: OptionsWidget(controller: controller, index: index),)
              ],
            ),
          );
        },
      ):EmptyListView(
          subTitle: translate(LocaleKeys.noDataFound),
          title: translate(LocaleKeys.sorry))),
    );
  }
}

class OptionsWidget extends StatelessWidget {
  const OptionsWidget({super.key, required this.controller, required this.index});

  final MyVehiclesController controller;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      child: Column(
        children: [
          Expanded(child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                controller.moveAddEditScreen(controller.vehiclesList[index].id ?? 0);
              },
              child: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit,width: 15,height: 15),
            ),
          )),
          const Divider(),
          Expanded(child: Material(
            color: Colors.white,
            child: InkWell(
              onTap: () {
                controller.showDeleteAlert(controller.vehiclesList[index].id ?? 0);
              },
              child: const Icon(Icons.delete_outline_outlined,color: Colors.red,size: 20,),
            ),
          )),
        ],
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
              style: TextStyle(fontSize: 18, color: AppColors.labelColor2),
            ),
          ],
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
            style: TextStyle(color: AppColors.iconColor, fontSize: 16),
          ),
          const SizedBox(height: 5),
          Text(
            text,
            style: TextStyle(color: AppColors.btmTextColor, fontSize: 16),
          )
        ],
      ),
    );
  }
}