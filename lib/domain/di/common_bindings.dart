import 'package:get/get.dart';

import '../../../config.dart';
import '../../../infrastructure/dal/services/api_service.dart';
import '../../../infrastructure/storage/app_storage.dart';

class CommonBindings implements Bindings{
  @override
  void dependencies() {
    Get.put<ApiService>(
          ApiService(
          baseUrl: ConfigEnvironments.getEnvironments()['url'] ?? ""),
    );
    Get.put<AppStorage>(AppStorage());
  }
}