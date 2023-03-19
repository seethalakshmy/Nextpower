import 'package:flutter/material.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/border_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/utils/input_formatter_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

class MobileNumberWidget extends StatelessWidget {
  const MobileNumberWidget({
    required this.onMobileNumberChanged,
    required this.onCountryCodeChanged,
    required this.validator,
    this.errorText = "",
    super.key,
    required this.countryCode,
    required this.title,
    this.isEnabled = true,
    this.mobileNumber = "",
    this.suffix,
  });

  final Function onCountryCodeChanged;
  final Function onMobileNumberChanged;
  final FormFieldValidator validator;
  final String errorText;
  final String countryCode;
  final String title;
  final bool isEnabled;
  final String mobileNumber;

  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty)
          Text(
            title,
            style:
                TextStyle(fontSize: 18, color: AppColors.titleLabelTextColor),
          ),
        if (title.isNotEmpty) const SizedBox(height: 10),
        Row(
          children: [
            Container(
                decoration: CustomBorders().containerBorder(
                    color: errorText.isNotEmpty ? AppColors.errorRed : null),
                child: DropdownButton<String>(
                  value: countryCode,
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
                  onChanged: !isEnabled
                      ? null
                      : (value) {
                          onCountryCodeChanged(value);
                        },
                )),
            const SizedBox(width: 10),
            Expanded(
              child: TextFormField(
                style: TextStyle(color: isEnabled ? null : Colors.grey),
                initialValue: mobileNumber,
                enabled: isEnabled,
                onTapOutside: (event) {
                  FocusManager.instance.primaryFocus?.unfocus();
                },
                keyboardType: TextInputType.number,
                inputFormatters: InputFormatterUtils().onlyNumber(),
                validator: validator,
                decoration: CustomDecorationUtils().textFieldDecoration(
                    hintText: translate(
                      LocaleKeys.mobileNumber,
                    ),
                    color: errorText.isNotEmpty ? AppColors.errorRed : null,
                    suffix: suffix),
                onChanged: (value) {
                  onMobileNumberChanged(value);
                },
              ),
            ),
          ],
        ),
        errorText.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 10.0, top: 5),
                child: Text(errorText,
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.errorRed,
                    )),
              )
      ],
    );
  }
}