import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/card/custom_card_view.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/empty_list_view.dart';

import 'controllers/my_address.controller.dart';
import 'widgets/show_address_widget.dart';

class MyAddressScreen extends GetView<MyAddressController> {
  const MyAddressScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: CustomAppbar(
          title: translate(LocaleKeys.myAddress),
          centerTitle: false,
        ),
        floatingActionButton:
            !controller.isLoading.value && controller.address.isEmpty
                ? FloatingActionButton(
                    onPressed: () {
                      controller.moveAddEditScreen(0);
                    },
                    backgroundColor: AppColors.primaryGreen,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(28)),
                    child: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  )
                : null,
        body: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : controller.address.isEmpty
                ? EmptyListView(
                    subTitle: 'Kindly please add address',
                    title: 'Sorry No Address found')
                : ListView(
                    children: [
                      const SizedBox(height: 10),
                      SvgImageUtils().showSvgFromAsset(
                          Assets.iconsMyAddressLocation,
                          width: 150,
                          height: 150),
                      // const SizedBox(height: 10),
                      _ContentView(
                        controller: controller,
                      ),
                    ],
                  ))));
  }
}

class _ContentView extends StatelessWidget {
  const _ContentView({
    super.key,
    required this.controller,
  });

  final MyAddressController controller;

  @override
  Widget build(BuildContext context) {
    return CustomCardView(
      padding: const EdgeInsets.symmetric(vertical: 20),
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: (controller.address).length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        translate(LocaleKeys.address),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        controller.moveAddEditScreen(
                            controller.address[0].id!.toInt());
                      },
                      child: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                ShowAddressWidget(
                  addressLine1: controller.address[index].addressLine1 ?? "",
                  addressLine2: controller.address[index].addressLine2 ?? "",
                  city: controller.address[index].city ?? "",
                  country: controller.userCountryItem.value,
                  state: controller.userStateItem.value,
                  postalCode: controller.address[index].postalCode ?? "",
                ),
                const SizedBox(height: 10),
              ],
            ),
          );
        },
      ),
    );
  }
}
