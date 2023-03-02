import 'package:get/get.dart';

import '../../../config.dart';
import '../../../infrastructure/dal/services/api_service.dart';
import '../../../infrastructure/storage/app_storage.dart';

class CommonBindings {
  static init() {
    Get.lazyPut<ApiService>(
          () => ApiService(
          baseUrl: ConfigEnvironments.getEnvironments()['url'] ?? ""),
    );
    Get.lazyPut<AppStorage>(() => AppStorage());
  }
}