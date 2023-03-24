import 'package:flutter/material.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/svg_util.dart';

class ShowAddressWidget extends StatelessWidget {
  const ShowAddressWidget({
    super.key,
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.country,
    required this.state,
    required this.postalCode,
  });

  final String addressLine1;
  final String addressLine2;
  final String city;
  final String country;
  final String state;
  final String postalCode;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SvgImageUtils()
            .showSvgFromAsset(Assets.iconsLocation, width: 21, height: 25.2),
        const SizedBox(width: 10),
        Expanded(
          child: Wrap(
            children: [
              _TextWidget(addressLine1 +
                  (addressLine1.isNotEmpty && addressLine2.isNotEmpty
                      ? ", "
                      : "")),
              _TextWidget(addressLine2 +
                  (addressLine2.isNotEmpty && city.isNotEmpty ? ", " : "")),
              _TextWidget(
                  city + (city.isNotEmpty && state.isNotEmpty ? ", " : "")),
              _TextWidget(
                  state + (state.isNotEmpty && country.isNotEmpty ? ", " : "")),
              _TextWidget(country +
                  (country.isNotEmpty && postalCode.isNotEmpty
                      ? " - $postalCode"
                      : ""))
            ],
          ),
        ),
      ],
    );
  }
}

class _TextWidget extends StatelessWidget {
  const _TextWidget(this.text);

  final String? text;

  @override
  Widget build(BuildContext context) {
    print(text);
    return Text(
      text ?? "",
      style: TextStyle(color: AppColors.iconColor, fontSize: 16),
    );
  }
}