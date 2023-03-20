import 'package:get/get.dart';
import 'package:project/presentation/station_list/models/stations_list_model.dart';
import 'package:project/presentation/station_list/providers/stations_list_provider.dart';

class StationListController extends GetxController {
  final isLoading = false.obs;
  List<Station> stationList = [];

  @override
  void onInit() {
    isLoading(true);
    StationsListProvider().getStationsList().then((value) {
      stationList = value?.stationList ?? [];
      isLoading(false);
    });
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
}