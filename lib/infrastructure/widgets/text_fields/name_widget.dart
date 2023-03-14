import 'package:flutter/material.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';

class NameWidget extends StatelessWidget {
  const NameWidget({
    required this.title,
    required this.onNameChanged,
    required this.validator,
    this.errorText = "",
    super.key,
  });

  final Function onNameChanged;
  final FormFieldValidator validator;
  final String errorText;
  final String title;

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
        TextFormField(
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: TextInputType.name,
          validator: validator,
          decoration: CustomDecorationUtils().textFieldDecoration(
              hintText: translate(
                title,
              ),
              color: errorText.isNotEmpty ? AppColors.errorRed : null),
          onChanged: (value) {
            onNameChanged(value);
          },
        ),
        errorText.isEmpty
            ? Container()
            : Padding(
                padding: const EdgeInsets.only(left: 5.0, top: 5),
                child: Text(
                  errorText,
                  style: TextStyle(color: AppColors.errorRed),
                ),
              )
      ],
    );
  }
}