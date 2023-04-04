import 'package:flutter/material.dart';

import 'package:get/get.dart';

import 'controllers/wallet_list.controller.dart';

class WalletListScreen extends GetView<WalletListController> {
  const WalletListScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('WalletListScreen'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'WalletListScreen is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
