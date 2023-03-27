import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:project/infrastructure/widgets/drawer/custom_drawer.dart';
import 'package:project/presentation/home/views/usage_history_view.dart';

import 'controllers/home.controller.dart';
import 'views/favourites_view.dart';
import 'views/station_view_with_state.dart';
import 'views/wallet_view.dart';
import 'widgets/bottom_navigation_bar_widget.dart';

class HomeScreen extends GetView<HomeController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('HomeScreen'),
        centerTitle: true,
      ),
      drawer: const CustomDrawerWidget(),
      bottomNavigationBar: const BottomNavigationBarWidget(),
      body: const HomeContentView(),
    );
  }
}

class HomeContentView extends GetView<HomeController> {
  const HomeContentView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.selectedIndex.value == controller.stationIndex) {
        return const StationView();
      } else if (controller.selectedIndex.value == controller.historyIndex) {
        return const UsageHistoryView();
      } else if (controller.selectedIndex.value == controller.favoritesIndex) {
        return const FavouritesView();
      } else if (controller.selectedIndex.value == controller.walletIndex) {
        return const WalletView();
      } else {
        return Container();
      }
    });
  }
}