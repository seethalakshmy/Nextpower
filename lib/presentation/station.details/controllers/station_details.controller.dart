import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/station_details/ConnectorsResponse.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/presentation/station.details/models/station_details_model.dart';
import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/station_details/station_details_model.dart';
import '../../../infrastructure/dal/providers/station_details/station_details_provider.dart';
import '../../../infrastructure/utils/snackbar_utils.dart';

class StationDetailsController extends GetxController {
  int stationId = 0;
  StationDetails? details;
  RxBool isLoading = false.obs;
  RxBool isSelectedConnectorView = true.obs;
  RxBool isAllFilterChosen = true.obs;
  RxBool isFavorite = false.obs;

  RxList<int> openedIndexes = <int>[].obs;
  RxList<Connectors> connectionList = RxList<Connectors>.empty(growable: true);
  Rx<Station> stationDetails = Station().obs;

  @override
  void onInit() {
    isLoading(true);
    stationId = int.parse((Get.parameters[ParamName.stationId] ?? "0"));

    getStationDetails();
    getConnectors();
    super.onInit();
  }

  void getStationDetails() {
    isLoading(true);
    stationId = int.parse((Get.parameters[ParamName.stationId] ?? "0"));
    StationDetailsProvider().getStationDetails(id: stationId).then((value) {
      if (value.status ?? false){
        stationDetails.value = value.station!;
        isFavorite.value = stationDetails.value.overview?.isFavorite ?? false;
      }else{
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value.message ?? "");
      }
      isLoading(false);
    });
  }

  void getConnectors() {
    isLoading(true);
    StationDetailsProvider()
        .getConnectors(stationId: stationId.toString())
        .then((value) {
      isLoading(false);
      ConnectorsResponse response = value;
      if (response.status ?? false) {
        connectionList.value = response.connectors ?? [];
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
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

    //var list = stationDetails?.overview?.amenities ?? [];
    // for (int i = 0; i < list.length; i++) {
    //   amenities = amenities + list[i];
    //   if (i != list.length - 1) {
    //     amenities = "$amenities | ";
    //   }
    // }
     return amenities;
  }
}