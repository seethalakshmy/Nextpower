import 'package:flutter/material.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/widgets/text/subtitle_widget.dart';

import 'station_status_widget.dart';

class ChargingPowerStatusWidget extends StatelessWidget {
  const ChargingPowerStatusWidget({
    super.key,
    required this.connectorPower,
    required this.connectorStatus,
  });

  final String connectorPower;
  final String connectorStatus;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      crossAxisAlignment: WrapCrossAlignment.center,
      alignment: WrapAlignment.start,
      children: [
        SvgImageUtils()
            .showSvgFromAsset(Assets.iconsMenuStation, width: 20, height: 20),
        const SizedBox(width: 5),
        SubtitleWidget(
          subtitle: connectorPower,
          fontSize: 16,
        ),
        const SizedBox(width: 15),
        StationStatusWidget(stationStatus: connectorStatus)
      ],
    );
  }
}