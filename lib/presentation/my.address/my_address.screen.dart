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
import 'package:project/presentation/empty_list_view.dart';

import 'controllers/my_address.controller.dart';

class MyAddressScreen extends GetView<MyAddressController> {
  const MyAddressScreen({Key? key}) : super(key: key);

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
                      NavigationUtils().callMyAddressAddEditPage(0);
                    },
                    backgroundColor: AppColors.primaryGreen,
                    child: const Icon(Icons.add),
                  )
                : null,
        body: Obx(() => controller.isLoading.value
            ? const LoadingWidget()
            : controller.address.isEmpty
                ? EmptyListView(
                    subTitle: 'Kindly please add address',
                    title: 'Oops! No Address found')
                : ListView(
                    children: [
                      const SizedBox(height: 10),
                      SvgImageUtils()
                          .showSvgFromAsset(Assets.iconsMyAddressLocation),
                      const SizedBox(height: 10),
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
                        NavigationUtils().callMyAddressAddEditPage(
                            controller.address[index].addressId ?? 0);
                      },
                      child: SvgImageUtils().showSvgFromAsset(Assets.iconsEdit),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgImageUtils().showSvgFromAsset(Assets.iconsLocation),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            Text(controller.address[index].addressLine1 ?? ""),
                            Text(
                                "${(controller.address[index].addressLine2 != null || controller.address[index].addressLine2!.isNotEmpty) ? "," : ""} ${controller.address[index].addressLine2 ?? ""}"),
                            Text(
                                "${(controller.address[index].city != null || controller.address[index].city!.isNotEmpty) ? "," : ""} ${controller.address[index].city ?? ""}"),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(controller.address[index].postalCode ?? "")
                      ],
                    )
                  ],
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