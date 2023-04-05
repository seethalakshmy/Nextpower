import 'package:get/get.dart';
import 'package:project/presentation/about.us/about_us_model.dart';
import 'package:project/presentation/about.us/providers/about_us_provider.dart';

class AboutUsController extends GetxController {
  AboutUs? aboutUs;
  final isLoading = true.obs;

  @override
  void onInit() {
    AboutUsProvider().getAboutUs().then((value) {
      aboutUs = value;
      isLoading(false);
    });
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
}