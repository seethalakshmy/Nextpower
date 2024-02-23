import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/buttons/rounded_rectangle_button.dart';
import 'package:project/presentation/login/controllers/login_controller.dart';

class ContinueButtonWidget extends GetView<LoginController> {
  const ContinueButtonWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => RoundedRectangleButton(
          isLoading: controller.isLoading.value,
          onPressed: () {
            controller.gotoNextPage();
          },
          text: translate(LocaleKeys.continueLabel),
        ));
  }
}
