import 'package:get/get.dart';
import 'package:project/infrastructure/navigation/routes.dart';

class NavigationUtils {
  void callLoginPage() {
    Get.toNamed(Routes.LOGIN);
  }
}