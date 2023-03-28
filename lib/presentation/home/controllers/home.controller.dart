import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
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
  Position? position;

  GoogleMapController? mapController;

  @override
  void onInit() async {
    setSelectedIndex(int.parse(
        (Get.parameters[ParamName.index] ?? stationIndex).toString()));
    stationList =
        (await StationsListProvider().getStationsList())?.stations ?? [];
    // await determinePosition();
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
}