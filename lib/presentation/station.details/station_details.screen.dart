import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';
import 'package:project/infrastructure/widgets/loaders/loading_widget.dart';
import 'package:project/presentation/empty_list_view.dart';

import 'controllers/station_details.controller.dart';

class StationDetailsScreen extends GetView<StationDetailsController> {
  const StationDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppbar(
        title: '',
        elevation: 0.0,
      ),
      body: Obx(() =>
      controller.isLoading.value
          ? const LoadingWidget()
          : controller.details == null
          ? EmptyListView(subTitle: 'No such station found', title: 'Oops')
          : Column(
        children: [
          _HeaderView(
            controller: controller,
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Obx(
                      () =>
                      _FilterTextView(
                        text: translate(LocaleKeys.all),
                        isSelected: controller.isAllFilterChosen.value,
                        onTap: () {
                          controller.isAllFilterChosen(true);
                        },
                      ),
                ),
                Container(
                  height: 12,
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  decoration: const BoxDecoration(
                      border: Border(
                          right: BorderSide(color: Colors.black))),
                ),
                Obx(
                      () =>
                      _FilterTextView(
                        text: translate(LocaleKeys.free),
                        isSelected: !controller.isAllFilterChosen.value,
                        onTap: () {
                          controller.isAllFilterChosen(false);
                        },
                      ),
                ),
              ],
            ),
          ),
          const Center(
            child: Text(
              'StationDetailsScreen is working',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ],
      )),
    );
  }
}

class _FilterTextView extends StatelessWidget {
  const _FilterTextView({
    super.key,
    required this.text,
    required this.isSelected, required this.onTap,
  });

  final String text;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Text(
        text,
        style:
        TextStyle(color: isSelected ? AppColors.labelGreenTextColor : null),
      ),
    );
  }
}

class _HeaderView extends StatelessWidget {
  const _HeaderView({
    super.key,
    required this.controller,
  });

  final StationDetailsController controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue,
      width: double.infinity,
      child: Column(
        children: [
          SvgImageUtils().showSvgFromAsset(Assets.iconsStationCarIllustration),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 30),
            child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.details?.stationName ?? "",
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w500),
                      ),
                      Container(
                        margin: const EdgeInsets.only(top: 10),
                        decoration: BoxDecoration(
                            color: (controller.details?.stationStatus ?? "")
                                .toLowerCase()
                                .compareTo('available') ==
                                0
                                ? AppColors.availableGreen
                                : Colors.red,
                            borderRadius:
                            const BorderRadius.all(Radius.circular(15.0))),
                        padding: const EdgeInsets.symmetric(
                            vertical: 5, horizontal: 15),
                        child: Text(
                          controller.details?.stationStatus ?? "",
                          style: const TextStyle(color: Colors.white),
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() =>
                  _TabHeadingView(
                    title: translate(LocaleKeys.connectors),
                    isSelected: controller.isSelectedConnectorView.value,
                    onTap: () {
                      controller.isSelectedConnectorView(true);
                    },
                  )),
              const SizedBox(width: 40),
              Obx(() =>
                  _TabHeadingView(
                    title: translate(LocaleKeys.overview),
                    isSelected: !controller.isSelectedConnectorView.value,
                    onTap: () {
                      controller.isSelectedConnectorView(false);
                    },
                  )),
            ],
          ),
        ],
      ),
    );
  }
}

class _TabHeadingView extends StatelessWidget {
  const _TabHeadingView({
    super.key,
    required this.title,
    required this.isSelected,
    required this.onTap,
  });

  final String title;
  final bool isSelected;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
            border: Border(
                bottom: BorderSide(
                    width: 3,
                    color: isSelected
                        ? AppColors.selectionColor
                        : Colors.transparent))),
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal),
        ),
      ),
    );
  }
}