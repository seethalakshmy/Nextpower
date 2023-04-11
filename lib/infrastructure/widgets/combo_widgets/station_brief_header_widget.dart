import 'package:flutter/material.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/utils/svg_util.dart';

import 'title_power_status_combo_widget.dart';

class StationBriefHeaderWidget extends StatelessWidget {
  const StationBriefHeaderWidget({
    super.key,
    required this.stationName,
    required this.connectorPower,
    required this.connectorStatus,
    required this.lat,
    required this.long,
  });

  final String stationName;
  final String connectorPower;
  final String connectorStatus;
  final double lat;
  final double long;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: TitlePowerStatusComboWidget(
              title: stationName,
              titleFontSize: 18,
              power: connectorPower,
              status: connectorStatus),
        ),
        IconButton(
            onPressed: () {
              NavigationUtils().callGoogleMap(lat, long);
            },
            icon: SvgImageUtils()
                .showSvgFromAsset(Assets.iconsDirection, width: 24, height: 24))
      ],
    );
  }
}