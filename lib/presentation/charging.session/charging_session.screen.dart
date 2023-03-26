import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/charging_session.controller.dart';

class ChargingSessionScreen extends GetView<ChargingSessionController> {
  const ChargingSessionScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ChargingSessionScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'ChargingSessionScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
