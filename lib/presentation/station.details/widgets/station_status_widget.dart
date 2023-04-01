import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class StationStatusWidget extends StatelessWidget {
  const StationStatusWidget({
    super.key,
    required this.stationStatus,
    this.margin,
  });

  final String stationStatus;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
          color: (stationStatus.toLowerCase().compareTo('available') == 0 ||
                  stationStatus.toLowerCase().compareTo('success') == 0)
              ? AppColors.availableGreen
              : Colors.red,
          borderRadius: const BorderRadius.all(Radius.circular(15.0))),
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
      child: Text(
        stationStatus,
        style: const TextStyle(color: Colors.white, fontSize: 11),
      ),
    );
  }
}