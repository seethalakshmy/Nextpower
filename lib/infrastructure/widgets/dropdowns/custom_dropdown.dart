import 'package:flutter/material.dart';
import 'package:project/infrastructure/widgets/text/title_widget.dart';

import '../../../generated/locales.g.dart';
import '../../utils/border_utils.dart';
import '../../utils/translation_util.dart';

class CustomDropdownWidget extends StatelessWidget {
  final String? fieldTitle;
  final String? dropDownHint;
  final String? errorMessage;
  final dynamic initialValue;
  final List<DropdownMenuItem<dynamic>> list;
  final FormFieldValidator<dynamic>? customValidator;
  final Function(dynamic) onSaved;
  final Function onChanged;
  final Function(dynamic)? onSubmitted;
  final FocusNode? focusNode;
  final Color? backgroundColor;
  final bool isRemoveInputBorder;
  final double? padding;
  final double? height;
  final bool ignorePointerValue;
  final Alignment? dropDownAlign;
  final InputDecoration? decoration;
  final double? menuHeight;

  const CustomDropdownWidget({
    Key? key,
    this.dropDownAlign,
    this.height,
    this.ignorePointerValue = false,
    this.fieldTitle,
    this.errorMessage,
    this.dropDownHint,
    this.initialValue,
    required this.list,
    this.customValidator,
    required this.onSaved,
    required this.onChanged,
    this.onSubmitted,
    this.focusNode,
    this.backgroundColor,
    this.isRemoveInputBorder = false,
    this.padding,
    this.decoration,
    this.menuHeight,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          fieldTitle != ''
              ? TitleWidget(title: fieldTitle ?? "")
              : const Padding(padding: EdgeInsets.zero),
          const SizedBox(height: 10),
          Container(
            height: height ?? 50,
            alignment: dropDownAlign ?? Alignment.centerLeft,
            color: backgroundColor ?? Colors.transparent,
            padding:
                EdgeInsets.only(left: padding ?? 0.0, right: padding ?? 0.0),
            child: DropdownButtonFormField<dynamic>(
              isDense: false,
              itemHeight: 50,
              menuMaxHeight: height,
              decoration: ignorePointerValue
                  ? InputDecoration.collapsed(hintText: '')
                  : InputDecoration(
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      border: CustomBorders().textFieldBorder()),
              focusNode: focusNode,
              hint: dropDownHint != null
                  ? Text(dropDownHint ?? "")
                  : Text(translate(LocaleKeys.choose)),
              icon: ignorePointerValue
                  ? const Icon(
                      Icons.keyboard_arrow_down,
                      color: Color(0x000364A4),
                    )
                  : Icon(Icons.keyboard_arrow_down),
              items: list,
              value: initialValue,
              // decoration:  InputDecoration(errorText: errorMessage,),
              onChanged: (value) {
                onChanged(value);
                // validator(value);
              },
              isExpanded: true,
              validator: (value) {
                print("CustomDropdownWidget validator: $value");
                return customValidator!(value);
              },
              onSaved: (value) => onSaved(value),
            ),
          ),
        ]);
  }
}