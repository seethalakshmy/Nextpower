import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

import 'controllers/splash.controller.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreenScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  String versionNumber = "";

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SplashContent(
        versionNumber: versionNumber,
      ),
    );
  }
}

class SplashContent extends StatelessWidget {
  const SplashContent({
    super.key,
    required this.versionNumber,
  });

  final String versionNumber;

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<SplashScreenController>();
    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Image(
            image: AssetImage(Assets.logoLogo),
            height: 200,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Obx(() {
                  return Text(
                    "V ${controller.versionName}",
                    style: TextStyle(
                        color: AppColors.labelTextColor3,
                        fontSize: 12,
                        fontWeight: FontWeight.w600),
                  );
                }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// class SplashScreenScreen extends GetView<SplashScreenController> {
//   const SplashScreenScreen({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       color: Colors.white,
//       padding: const EdgeInsets.symmetric(horizontal: 30),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.center,
//         children: [
//           const SizedBox(
//             height: 10,
//           ),
//           const Image(
//             image: AssetImage(Assets.logoLogo),
//             height: 200,
//           ),
//           Container(
//             padding: const EdgeInsets.only(bottom: 30),
//             child: Column(
//               children: [
//                 Text(
//                   "V ",
//                   style: TextStyle(
//                       color: AppColors.labelTextColor3,
//                       fontSize: 12,
//                       fontWeight: FontWeight.w600),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
