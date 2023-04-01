import 'package:flutter/material.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/combo_widgets/station_brief_header_widget.dart';
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
        NavigationUtils().callStationDetails(stationDetail.stationId ?? 0);
      },
      child: Dialog(
        child: IntrinsicHeight(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                StationBriefHeaderWidget(
                  stationName: stationDetail.stationName ?? "",
                  connectorPower: stationDetail.kwh ?? "",
                  connectorStatus: stationDetail.status ?? "",
                  lat: stationDetail.lat ?? 0.0,
                  long: stationDetail.long ?? 0.0,
                ),
                const SizedBox(height: 20),
                Row(
                  children: [
                    ContentItem(
                        title: translate(LocaleKeys.distance),
                        value: stationDetail.distance ?? "",
                        bgColor: AppColors.dialogLightPink,
                        textColor: AppColors.dialogPink),
                    const SizedBox(width: 5),
                    ContentItem(
                        title: translate(LocaleKeys.free),
                        value: (stationDetail.free ?? 0).toString(),
                        bgColor: AppColors.dialogLightGreen,
                        textColor: AppColors.dialogGreen),
                    const SizedBox(width: 5),
                    ContentItem(
                        title: translate(LocaleKeys.active),
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

class ContentItem extends StatelessWidget {
  const ContentItem({
    super.key,
    required this.title,
    required this.value,
    required this.bgColor,
    required this.textColor,
    this.alignment,
    this.crossAxisAlignment,
  });

  final String title;
  final String value;
  final Color bgColor;
  final Color textColor;
  final AlignmentGeometry? alignment;
  final CrossAxisAlignment? crossAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(5.0),
        alignment: alignment ?? Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: bgColor,
        ),
        child: Column(
          crossAxisAlignment: crossAxisAlignment ?? CrossAxisAlignment.center,
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