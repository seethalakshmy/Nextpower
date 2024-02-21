import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/domain/di/common_bindings.dart';
import 'package:project/infrastructure/theme/app_theme.dart';
import 'package:project/presentation/splash_screen/controllers/splash.controller.dart';

import 'generated/locales.g.dart';
import 'infrastructure/navigation/navigation.dart';
import 'infrastructure/navigation/routes.dart';

void main() async {
  var initialRoute = await Routes.initialRoute;
  runApp(Main(initialRoute));
}

class Main extends StatelessWidget {
  final String initialRoute;
  Main(this.initialRoute);

  @override
  Widget build(BuildContext context) {
    SplashScreenController controller = Get.put(SplashScreenController());
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: CommonBindings(),
      initialRoute: initialRoute,
      getPages: Nav.routes,
      translationsKeys: AppTranslation.translations,
      supportedLocales: const [
        Locale('en', 'US'),
      ],
      locale: const Locale('en', 'US'),
      fallbackLocale: const Locale('en', 'US'),
      theme: AppThemes.light,
    );
  }
}
