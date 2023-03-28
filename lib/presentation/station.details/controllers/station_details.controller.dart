import 'package:get/get.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/station.details/models/station_details_model.dart';
import 'package:project/presentation/station.details/providers/station_details_provider.dart';

class StationDetailsController extends GetxController {
  int stationId = 0;
  StationDetails? details;
  RxBool isLoading = false.obs;
  RxBool isSelectedConnectorView = true.obs;
  RxBool isAllFilterChosen = true.obs;

  RxList<int> openedIndexes = <int>[].obs;

  @override
  void onInit() {
    isLoading(true);
    stationId = int.parse((Get.parameters[ParamName.stationId] ?? "0"));
    StationDetailsProvider().getStationDetails(stationId).then((value) {
      details = value;
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

  setIndexesData(index) {
    if (openedIndexes.contains(index)) {
      openedIndexes.remove(index);
    } else {
      openedIndexes.add(index);
    }
  }

  String getAmenities() {
    String amenities = "";

    var list = details?.overview?.amenities ?? [];
    for (int i = 0; i < list.length; i++) {
      amenities = amenities + list[i];
      if (i != list.length - 1) {
        amenities = "$amenities | ";
      }
    }
    return amenities;
  }
}