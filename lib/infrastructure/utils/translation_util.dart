import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/constants.dart';

String translate(String text) {
  return text.tr;
}


Color getStatusColor(String status){
  Color color = AppColors.availableGreen;
  switch(status.toLowerCase()){
    case "available":
      color = AppColors.availableGreen;
      break;
    case "preparing":
      color = Colors.blue;
      break;
    case "charging":
      color = Colors.black45;
      break;
    case "suspendedev":
      color = Colors.red.withOpacity(0.8);
      break;
    case "suspendedevse":
      color = Colors.red.withOpacity(0.8);
      break;
    case "finishing":
      color = Colors.purple;
      break;
    case "reserved":
      color = AppColors.darkOrange;
      break;
    default :
    color = Colors.red;
      break;
  }
  return color;
}