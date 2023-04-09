import 'package:flutter/material.dart';
import 'package:project/infrastructure/utils/decoration_utils.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

class CommonTextFieldWidget extends StatelessWidget {
  const CommonTextFieldWidget({
    required this.title,
    required this.onChanged,
    required this.validator,
    // this.errorText = "",
    super.key,
    this.initialValue,
    this.suffix,
    this.editingController,
    this.fontSize,
  });

  // : assert((initialValue != null && editingController != null) == true);

  final Function onChanged;
  final Widget? suffix;
  final double? fontSize;
  final FormFieldValidator validator;

  // final String errorText;
  final String title;
  final String? initialValue;
  final TextEditingController? editingController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title.isNotEmpty) TitleWidget(title: title),
        if (title.isNotEmpty) const SizedBox(height: 10),
        SizedBox(
          height: 50,
          child: TextFormField(
            textAlignVertical: TextAlignVertical.center,
            initialValue: initialValue,
            controller: editingController,
            style: TextStyle(fontSize: fontSize),
            onTapOutside: (event) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
            keyboardType: TextInputType.name,
            validator: validator,
            decoration: CustomDecorationUtils().textFieldDecoration(
              // hintText: translate(title),
              // color: errorText.isNotEmpty ? AppColors.errorRed : null,
              suffix: suffix,
            ),
            onChanged: (value) {
              onChanged(value);
            },
          ),
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