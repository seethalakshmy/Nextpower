import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/splash_screen.controller.dart';

class SplashScreenScreen extends GetView<SplashScreenController> {
  const SplashScreenScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SplashScreenScreen'),
        centerTitle: true,
      ),
      body: Center(
        child: Text(
          'SplashScreenScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
