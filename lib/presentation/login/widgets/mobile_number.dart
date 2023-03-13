import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/border_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/utils/input_formatter_utils.dart';
import 'package:project/infrastructure/utils/print_utils.dart';
import 'package:project/infrastructure/utils/validation_utils.dart';

import '../controllers/login.controller.dart';

class MobileNumberWidget extends GetView<LoginController> {
  const MobileNumberWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              decoration: CustomBorders().containerBorder(),
              child: Obx(() {
                return DropdownButton<String>(
                  value: controller.selectedCountryCode.value,
                  underline: Container(),
                  items: AppConstants().countryCodeList.map((String items) {
                    return DropdownMenuItem(
                      value: items,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Text(items),
                      ),
                    );
                  }).toList(),
                  icon: const Padding(
                    padding: EdgeInsets.only(right: 8.0),
                    child: Icon(Icons.keyboard_arrow_down),
                  ),
                  onChanged: (value) {
                    PrintUtils().prints(message: "Selected ", value: value);
                    controller.setCountryCode(value);
                  },
                );
              }),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                keyboardType: TextInputType.number,
                inputFormatters: InputFormatterUtils().onlyNumber(),
                validator: (value) {
                  controller.mobileNumberError(
                      ValidationUtils().mobileNumberValidation(value) ?? "");
                  return null;
                },
                decoration: CustomDecorationUtils()
                    .textFieldDecoration(hintText: LocaleKeys.mobileNumber.tr),
                onChanged: (value) {
                  controller.mobileNumber = value;
                },
              ),
            ),
          ],
        ),
        Obx(() {
          return controller.mobileNumberError.value.isEmpty
              ? Container()
              : Padding(
                  padding: const EdgeInsets.only(left: 5.0, top: 5),
                  child: Text(
                    controller.mobileNumberError.value,
                    style: TextStyle(color: AppColors.errorRed),
                  ),
                );
        })
      ],
    );
  }
}