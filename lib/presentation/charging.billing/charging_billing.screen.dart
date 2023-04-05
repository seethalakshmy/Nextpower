import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/utils/translation_util.dart';
import 'package:project/infrastructure/widgets/appbar/custom_appbar.dart';

import 'controllers/charging_billing.controller.dart';

class ChargingBillingScreen extends GetView<ChargingBillingController> {
  const ChargingBillingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppbar(
        title: controller.pageIndex == 1
            ? translate(LocaleKeys.charging)
            : translate(LocaleKeys.billing),
      ),
      body: Center(
        child: Text(
          '${controller.pageIndex == 1 ? translate(LocaleKeys.charging) : translate(LocaleKeys.billing)} content will be shown',
          style: const TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}