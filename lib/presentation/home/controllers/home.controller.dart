import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/station_list/models/stations_list_model.dart';
import 'package:project/presentation/station_list/providers/stations_list_provider.dart';

class HomeController extends GetxController {
  final int stationIndex = 1;
  final int historyIndex = 2;
  final int favoritesIndex = 3;
  final int walletIndex = 4;

  final selectedIndex = 0.obs;
  final RxBool isLoading = true.obs;
  final RxBool isMapLoaded = true.obs;
  final Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();

  static const CameraPosition kGooglePlex = CameraPosition(
    target: LatLng(56.172249, 10.187372),
    zoom: 14.4746,
  );
  RxList<Marker> allMarkers = <Marker>[].obs; // Inside Map View Controller
  List<Stations> stationList = [];

  @override
  void onInit() {
    setSelectedIndex(int.parse(
        (Get.parameters[ParamName.index] ?? stationIndex).toString()));
    StationsListProvider().getStationsList().then((value) {
      stationList = value?.stations ?? [];
    });
    onMapCreated();
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

  void setSelectedIndex(int index) async {
    isLoading(true);
    await Future.delayed(const Duration(seconds: 2));
    isLoading(false);
    selectedIndex.value = index;
  }

  Future<void> onMapCreated() async {
    print("onMapCreated()");
    allMarkers.clear();
    var fromAssetImage = await BitmapDescriptor.fromAssetImage(
        const ImageConfiguration(), Assets.assetsIconsChargerIcon);
    for (final Stations station in stationList) {
      final marker = Marker(
        icon: fromAssetImage,
        markerId: MarkerId(station.stationId.toString()),
        position: LatLng(station.lat ?? 0.0, station.long ?? 0.0),
        infoWindow: InfoWindow(
          title: station.stationName,
          snippet: station.distance,
        ),
      );
      allMarkers.add(marker);
      update();
      isMapLoaded(true);
    }
  }
}