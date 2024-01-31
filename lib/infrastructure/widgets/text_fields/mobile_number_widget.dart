import 'package:flutter/material.dart';
import 'package:project/infrastructure/dal/models/countries/CountryResponse.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/border_utils.dart';
import 'package:project/infrastructure/utils/constants.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/utils/input_formatter_utils.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

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
    required this.countries,
    this.countryLoading = false,
    this.suffix,
  });

  final Function onCountryCodeChanged;
  final Function onMobileNumberChanged;
  final FormFieldValidator validator;
  final String errorText;
  final String countryCode;
  final String title;
  final bool isEnabled;
  final bool countryLoading;
  final String mobileNumber;
  final List<Country> countries;

  final Widget? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) TitleWidget(title: title),
        if (title.isNotEmpty) const SizedBox(height: 10),
        Row(
          children: [
            Container(
                decoration: CustomBorders().containerBorder(
                    color: errorText.isNotEmpty ? AppColors.errorRed : null),
                child: countryLoading
                    ? buildLoading()
                    : DropdownButton<String>(
                        value: countryCode,
                        underline: Container(),
                        items: countries.map((Country items) {
                          return DropdownMenuItem(
                            value: "${items.countryCode ?? 91}",
                            child: Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text("+${items.countryCode ?? 91}"),
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
              child: SizedBox(
                height: 50,
                child: TextFormField(
                  style: TextStyle(color: isEnabled ? null : Colors.grey),
                  initialValue: mobileNumber,
                  enabled: isEnabled,
                  onTapOutside: (event) {
                    FocusManager.instance.primaryFocus?.unfocus();
                  },
                  keyboardType: TextInputType.number,
                  // maxLength: 15,
                  inputFormatters: InputFormatterUtils().onlyNumber(),
                  validator: validator,
                  decoration: CustomDecorationUtils().textFieldDecoration(
                      color: errorText.isNotEmpty ? AppColors.errorRed : null,
                      suffix: suffix),
                  onChanged: (value) {
                    onMobileNumberChanged(value);
                  },
                ),
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

  Widget buildLoading() {
    return Container(
      width: 50,
        height: 50,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(12),
        child: const CircularProgressIndicator());
  }
}
