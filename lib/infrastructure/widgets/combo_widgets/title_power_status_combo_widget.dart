import 'package:flutter/material.dart';

import '../../../presentation/station.details/widgets/charging_power_status_widget.dart';
import '../../theme/app_colors.dart';
import '../text/title_widget.dart';

class TitlePowerStatusComboWidget extends StatelessWidget {
  const TitlePowerStatusComboWidget({
    super.key,
    required this.title,
    required this.power,
    required this.status,
    this.titleFontSize,
  });

  final String title;
  final double? titleFontSize;
  final String power;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TitleWidget(
          title: title,
          fontWeight: FontWeight.bold,
          fontSize: titleFontSize ?? 20,
          color: AppColors.textTitleColor,
        ),
        const SizedBox(height: 10),
        ChargingPowerStatusWidget(
            connectorPower: power, connectorStatus: status),
      ],
    );
  }
}