import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UsageHistoryView extends GetView {
  const UsageHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Usage History is working',
        style: TextStyle(fontSize: 20),
      ),
    );
  }
}