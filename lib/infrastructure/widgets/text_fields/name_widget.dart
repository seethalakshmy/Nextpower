import 'package:flutter/material.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

class CommonTextFieldWidget extends StatelessWidget {
  const CommonTextFieldWidget({
    required this.title,
    required this.onNameChanged,
    required this.validator,
    // this.errorText = "",
    super.key,
    this.initialValue,
    this.suffix,
  });

  final Function onNameChanged;
  final Widget? suffix;
  final FormFieldValidator validator;

  // final String errorText;
  final String title;
  final String? initialValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) TitleWidget(title: title),
        if (title.isNotEmpty) const SizedBox(height: 10),
        TextFormField(
          initialValue: initialValue,
          onTapOutside: (event) {
            FocusManager.instance.primaryFocus?.unfocus();
          },
          keyboardType: TextInputType.name,
          validator: validator,
          decoration: CustomDecorationUtils().textFieldDecoration(
            hintText: translate(title),
            // color: errorText.isNotEmpty ? AppColors.errorRed : null,
            suffix: suffix,
          ),
          onChanged: (value) {
            onNameChanged(value);
          },
        ),
        // errorText.isEmpty
        //     ? Container()
        //     : Padding(
        //         padding: const EdgeInsets.only(left: 5.0, top: 5),
        //         child: Text(
        //           errorText,
        //           style: TextStyle(color: AppColors.errorRed),
        //         ),
        //       )
      ],
    );
  }
}