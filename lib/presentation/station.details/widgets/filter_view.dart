import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

import '../../../infrastructure/theme/app_colors.dart';
import '../controllers/station_details.controller.dart';

class FilterView extends GetView<StationDetailsController> {
  const FilterView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Obx(
            () => _FilterTextView(
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
                border: Border(right: BorderSide(color: Colors.black))),
          ),
          Obx(
            () => _FilterTextView(
              text: translate(LocaleKeys.free),
              isSelected: !controller.isAllFilterChosen.value,
              onTap: () {
                controller.isAllFilterChosen(false);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _FilterTextView extends StatelessWidget {
  const _FilterTextView({
    required this.text,
    required this.isSelected,
    required this.onTap,
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