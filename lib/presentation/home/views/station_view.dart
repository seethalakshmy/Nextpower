import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';

class StationView extends GetView<HomeController> {
  StationView({super.key});

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.infinity,
        child: Obx(() =>
        controller.isMapLoaded.value
            ? GoogleMap(

          mapType: MapType.normal,
          markers: Set<Marker>.of(controller.allMarkers.value),
          initialCameraPosition: HomeController.kGooglePlex,
          onMapCreated: (GoogleMapController mapController) {
            _controller.complete(mapController);
            controller.onMapCreated();
          },
        )
            : Container()));
  }
}