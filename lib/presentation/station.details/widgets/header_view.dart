import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../controllers/station_details.controller.dart';
import 'station_status_widget.dart';

class HeaderView extends GetView<StationDetailsController> {
  const HeaderView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.primaryBlue,
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BackButtonAppbar(),
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
                        controller.stationDetails.value.stationName ?? "",
                        style: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.w600),
                      ),
                      StationStatusWidget(
                        margin: const EdgeInsets.only(top: 10),
                        stationStatus: controller.stationDetails.value.stationStatus ?? "",
                      ),
                    ],
                  ),
                )),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Obx(() => _TabHeadingView(
                    title: translate(LocaleKeys.connectors),
                    isSelected: controller.isSelectedConnectorView.value,
                    onTap: () {
                      controller.isSelectedConnectorView(true);
                    },
                  )),
              const SizedBox(width: 40),
              Obx(() => _TabHeadingView(
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
                    width: 4,
                    color: isSelected
                        ? AppColors.tabUnderlineSelectedColor
                        : Colors.transparent))),
        padding: const EdgeInsets.only(bottom: 10),
        child: Text(
          title,
          style: TextStyle(
              color: isSelected ? Colors.white : AppColors.tabNotSelectedColor,
              fontSize: 16,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}