import 'dart:async';

import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';

class SplashScreenScreen extends StatefulWidget {
  const SplashScreenScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreenScreen> createState() => _SplashScreenScreenState();
}

class _SplashScreenScreenState extends State<SplashScreenScreen> {
  String versionNumber = "";

  @override
  void initState() {
    getVersionNumber();
    super.initState();
    Timer(const Duration(seconds: 3), () {
      NavigationUtils().goFromSplash();
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }

  Future getVersionNumber() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    String versionName = packageInfo.version;
    setState(() {
      versionNumber = versionName;
    });
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
    return Container(
      width: double.infinity,
      color: Colors.white,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(
            height: 10,
          ),
          const Image(
            image: AssetImage(Assets.logoLogo),
            width: 150,
            height: 150,
          ),
          Container(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Text(
                  "V $versionNumber",
                  style: TextStyle(
                      color: AppColors.primaryColor,
                      fontSize: 12,
                      fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}