import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/generated/assets.dart';
import 'package:project/infrastructure/dal/models/stations/StationsResponse.dart';
import 'package:project/infrastructure/navigation/navigation_utils.dart';
import 'package:project/infrastructure/theme/app_colors.dart';
import 'package:project/presentation/home/controllers/home.controller.dart';
import 'package:project/presentation/station.details/widgets/station_brief_details_widget.dart';

class StationView extends StatefulWidget {
  const StationView({Key? key}) : super(key: key);

  @override
  State<StationView> createState() => _StationViewState();
}

class _StationViewState extends State<StationView> {
  final HomeController _homeController = Get.put(HomeController());
  final Map<String, Marker> markers = <String, Marker>{};

  Future<void> onMapCreated(GoogleMapController controller) async {
    _homeController.mapController = controller;
    markers.clear();
    var fromAssetImage = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(),
      Assets.iconsStationLocation,
    );
    for (final Stations station in _homeController.stationList) {
      final marker = Marker(
          icon: fromAssetImage,
          markerId: MarkerId(station.stationId.toString()),
          position: LatLng(station.latitude ?? 0.0, station.longitude ?? 0.0),
          infoWindow: InfoWindow(
            title: station.stationName,
            snippet: "${station.distance ?? 0} Km",
          ),
          onTap: () {
            Get.dialog(StationBriefDetailsWidget(station));
          });
      setState(() {
        markers[station.stationId.toString()] = marker;
      });
      _homeController.isLoading(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            width: double.infinity,
            child: GoogleMap(
              mapType: MapType.normal,
              markers: markers.values.toSet(),
              myLocationButtonEnabled: false,
              initialCameraPosition: HomeController.cameraPosition,
              myLocationEnabled: true,
              zoomControlsEnabled: false,
              onMapCreated: (GoogleMapController mapController) {
                // controller.mapController.complete(mapController);
                onMapCreated(mapController);
              },
            )),
        Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.only(top: 20.0, right: 20),
              child: Column(
                children: [
                  FloatingActionButton(
                    heroTag: "CurrentLocation",
                    onPressed: () {
                      _homeController.determinePosition();
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.my_location,
                      color: AppColors.homeIconColor,
                    ),
                  ),
                  FloatingActionButton(
                    heroTag: "FilterView",
                    onPressed: () {
                      NavigationUtils().callScreenYetToBeDone();
                    },
                    mini: true,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.filter_alt_outlined,
                      color: AppColors.homeIconColor,
                    ),
                  ),
                ],
              ),
            )),
      ],
    );
  }
}