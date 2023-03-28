import 'package:flutter/material.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';
import 'package:project/presentation/station.details/widgets/charging_power_status_widget.dart';
import 'package:project/presentation/station_list/models/stations_list_model.dart';

class StationBriefDetailsWidget extends StatelessWidget {
  const StationBriefDetailsWidget(
    this.stationDetail, {
    super.key,
  });

  final Stations stationDetail;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        NavigationUtils().callStationDetails();
      },
      child: Dialog(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _HeaderWidget(stationDetail),
                const SizedBox(height: 20),
                Row(
                  children: [
                    _ContentItem(
                        title: 'Distance',
                        value: stationDetail.distance ?? "",
                        bgColor: AppColors.dialogLightPink,
                        textColor: AppColors.dialogPink),
                    const SizedBox(width: 5),
                    _ContentItem(
                        title: 'Free',
                        value: (stationDetail.free ?? 0).toString(),
                        bgColor: AppColors.dialogLightGreen,
                        textColor: AppColors.dialogGreen),
                    const SizedBox(width: 5),
                    _ContentItem(
                        title: 'Active',
                        value: (stationDetail.active ?? 0).toString(),
                        bgColor: AppColors.dialogLightOrange,
                        textColor: AppColors.dialogOrange)
                  ],
                ),
                const SizedBox(height: 10),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ContentItem extends StatelessWidget {
  const _ContentItem({
    super.key,
    required this.title,
    required this.value,
    required this.bgColor,
    required this.textColor,
  });

  final String title;
  final String value;
  final Color bgColor;
  final Color textColor;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: Column(
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 16, color: AppColors.labelTextColor4),
            ),
            Text(
              value,
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.w700, color: textColor),
            )
          ],
        ),
      ),
    );
  }
}

class _HeaderWidget extends StatelessWidget {
  const _HeaderWidget(
    this.stationDetail, {
    super.key,
  });

  final Stations stationDetail;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TitleWidget(
                title: stationDetail.stationName ?? "",
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color: AppColors.textTitleColor,
              ),
              const SizedBox(height: 10),
              ChargingPowerStatusWidget(
                  connectorPower: stationDetail.kwh ?? "",
                  connectorStatus: stationDetail.status ?? ""),
            ],
          ),
        ),
        IconButton(
            onPressed: () {
              NavigationUtils().callGoogleMap(
                  stationDetail.lat ?? 0.0, stationDetail.long ?? 0.0);
            },
            icon: SvgImageUtils().showSvgFromAsset(Assets.iconsDirection))
      ],
    );
  }
}