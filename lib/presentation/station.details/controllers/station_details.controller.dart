import 'package:get/get.dart';
import 'package:project/infrastructure/dal/models/station_details/ConnectorsResponse.dart';
import 'package:project/infrastructure/utils/param_name.dart';

import '../../../generated/locales.g.dart';
import '../../../infrastructure/dal/models/station_details/station_details_model.dart';
import '../../../infrastructure/dal/providers/favorites/favorites_provider.dart';
import '../../../infrastructure/dal/providers/station_details/station_details_provider.dart';
import '../../../infrastructure/utils/snackbar_utils.dart';

class StationDetailsController extends GetxController {
  int stationId = 0;
  int connectorId = 0;
  String fromQR = "";
  RxBool isLoading = false.obs;
  RxBool isSelectedConnectorView = true.obs;
  RxBool isAllFilterChosen = true.obs;
  RxBool isFavorite = false.obs;
  RxBool isFavoritesLoading = false.obs;

  RxList<int> openedIndexes = <int>[].obs;
  RxList<Connectors> connectionList = RxList<Connectors>.empty(growable: true);
  Rx<Station> stationDetails = Station().obs;

  @override
  void onInit() {
    isLoading(true);
    stationId = int.parse((Get.parameters[ParamName.stationId] ?? "0"));
    connectorId = int.parse((Get.parameters[ParamName.connectorId] ?? "0"));
    fromQR = Get.parameters[ParamName.from] ?? "";
    getStationDetails();
    getConnectors();
    super.onInit();
  }

  void getStationDetails() {
    isLoading(true);
    StationDetailsProvider()
        .getStationDetails(
            id: connectorId, fromQR: fromQR, stationID: stationId)
        .then((value) {
      if (value.status ?? false) {
        stationDetails.value = value.station!;
        isFavorite.value = stationDetails.value.overview?.isFavorite ?? false;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value.message ?? "");
      }
      isLoading(false);
      fromQR = "";
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

  void removeAddFavorite(int stationId, int favoriteId) async {
    isFavoritesLoading.value = true;
    FavoriteProvider()
        .removeOrAddFavoritesListItem(
            favoriteId: favoriteId, stationId: stationId ?? 0)
        .then((response) {
      if (response.status == true) {
        if (favoriteId == 1) {
          isFavorite.value = true;
        } else {
          isFavorite.value = false;
        }
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
      isFavoritesLoading.value = false;
    });
  }
}
