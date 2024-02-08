import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/stations/StationsDetailsResponse.dart';
import 'package:project/infrastructure/dal/models/stations/StationsResponse.dart';
import 'package:project/infrastructure/dal/providers/favorites/favorites_provider.dart';
import 'package:project/infrastructure/dal/providers/home_stations/home_stations_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:project/presentation/home/models/usage_history_list_model.dart';
import 'package:project/presentation/home/models/wallet_detail_model.dart';
import 'package:project/presentation/home/providers/usage_history_list_provider.dart';
import 'package:project/presentation/home/providers/wallet_detail_provider.dart';
import '../../../infrastructure/dal/models/favorites/favorites_model.dart';
import '../models/favorites_list_model.dart';

class HomeController extends GetxController {
  final int stationIndex = 1;
  final int historyIndex = 2;
  final int favoritesIndex = 3;
  final int walletIndex = 4;
  final int successHistory = 1;
  final int pendingHistory = 2;

  final selectedIndex = 0.obs;
  RxInt walletChosenAmountIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isMapLoaded = true.obs;
  final Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();

  static const CameraPosition cameraPosition = CameraPosition(
    target: LatLng(10.065010195176646, 76.35613924535859),
    // zoom: 14.4746,
    zoom: 10 //increase to zoom
  );
  RxList<Marker> allMarkers = <Marker>[].obs; // Inside Map View Controller
  List<Stations> stationList = [];
  Position? position;

  GoogleMapController? mapController;

  RxList<Favorite> favoritesList = <Favorite>[].obs;
  final historySelectedIndex = 1.obs;
  final historyLoading = true.obs;
  List<UsageHistory> usageHistoryList = [];
  WalletDetail? walletDetail;
  final TextEditingController walletBalanceController = TextEditingController();

  @override
  void onInit() async {
    setSelectedIndex(int.parse(
        (Get.parameters[ParamName.index] ?? stationIndex).toString()));
    // await determinePosition();
    super.onInit();
    getStations();
    getFavoritesList();
  }

  void getStations() {
    isLoading(true);
    HomeStationsProvider()
        .getStations(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude)
        .then((value) {
      isLoading(false);
      StationsResponse response = value;
      if (response.status ?? false) {
        stationList = response.stations ?? [];
        onMapCreated();
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void getStationDetails() {
    isLoading(true);
    HomeStationsProvider().getStationDetails(stationId: '').then((value) {
      isLoading(false);
      StationsDetailsResponse response = value;
      if (response.status ?? false) {
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }

  void setSelectedIndex(int index) async {
    if (index == favoritesIndex) {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      selectedIndex.value = index;
      getFavoritesList();
    } else if (index == historyIndex) {
      selectedIndex.value = index;
      getUsageHistoryList(successHistory);
    } else if (index == walletIndex) {
      selectedIndex.value = index;
      getWalletData();
    } else {
      isLoading(true);
      await Future.delayed(const Duration(seconds: 2));
      selectedIndex.value = index;
      isLoading(false);
    }
  }

  Future<void> onMapCreated() async {
    allMarkers.clear();
    var fromAssetImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), Assets.iconsStationLocation);
    for (final Stations station in stationList) {
      final marker = Marker(
        icon: fromAssetImage,
        markerId: MarkerId(station.stationId.toString()),
        position: LatLng(station.latitude ?? 0.0, station.longitude ?? 0.0),
        infoWindow: InfoWindow(
          title: station.stationName ?? "",
          snippet: "${station.distance ?? 0} Km",
        ),
      );
      allMarkers.add(marker);
      isMapLoaded(true);
    }
    update();
  }

  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    position = await Geolocator.getCurrentPosition();
    print(
        "lat:${(position?.latitude ?? 0)} and long: ${(position?.longitude ?? 0)}");
    mapController?.animateCamera(CameraUpdate.newCameraPosition(CameraPosition(
      target: LatLng(position?.latitude ?? 0, position?.longitude ?? 0),
      zoom: 14.4746,
    )));
  }

  void getFavoritesList() {
    isLoading(true);
    FavoriteProvider().getFavoritesList().then((response){
      if (response.status == true) {
        favoritesList.value = response.favorites!;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
      isLoading(false);
    });
  }

  void removeAddFavorite(int currentIndex,int favoriteId) async {
    isLoading(true);
    final int? stationId = favoritesList[currentIndex].stationId?.toInt();
    FavoriteProvider().removeOrAddFavoritesListItem(favoriteId: favoriteId, stationId: stationId ?? 0).then((response){
      if (response.status == true) {
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
        getFavoritesList();
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
    isLoading(false);
  }


  void getUsageHistoryList(int historyOption) async {
    historyLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    UsageHistoryListProvider().getUsageHistoryList(historyOption).then((value) {
      usageHistoryList = value?.usageHistory ?? [];
      historyLoading(false);
    });
  }

  void setHistorySelectedIndex(int currentIndex) {
    historySelectedIndex(currentIndex);
    getUsageHistoryList(currentIndex);
  }



  void getWalletData() async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    WalletDetailProvider().getWalletDetail().then((value) {
      walletDetail = value;
      isLoading(false);
    });
  }


  void setWalletAmountChosenIndex({required int index, required int amount}) {
    walletChosenAmountIndex(index);
    walletBalanceController.text = amount.toString();
  }
}