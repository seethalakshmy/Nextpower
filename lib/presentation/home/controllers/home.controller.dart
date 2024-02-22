import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:project/generated/assets.dart';
import 'package:project/generated/locales.g.dart';
import 'package:project/infrastructure/dal/models/stations/StationsDetailsResponse.dart';
import 'package:project/infrastructure/dal/models/stations/StationsResponse.dart';
import 'package:project/infrastructure/dal/models/usage_history/UsageHistoryResponse.dart';
import 'package:project/infrastructure/dal/providers/favorites/favorites_provider.dart';
import 'package:project/infrastructure/dal/providers/home_stations/home_stations_provider.dart';
import 'package:project/infrastructure/dal/providers/usage_history/usage_history_provider.dart';
import 'package:project/infrastructure/utils/param_name.dart';
import 'package:project/infrastructure/utils/snackbar_utils.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../../../infrastructure/dal/models/Wallet/wallet_detail_response_model.dart';
import '../../../infrastructure/dal/models/favorites/favorites_model.dart';
import '../../../infrastructure/dal/providers/profile/profile_provider.dart';
import '../../../infrastructure/dal/providers/wallet/wallet_detail_provider.dart';

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
  RxString name = "".obs;
  RxString phoneNumber = "".obs;
  RxList<Marker> allMarkers = <Marker>[].obs; // Inside Map View Controller
  RxList<Favorite> favoritesList = <Favorite>[].obs;
  Rx<WalletDetailResponseModel> walletDetail = WalletDetailResponseModel().obs;
  final historyLoading = true.obs;
  late Razorpay _razorpay;
  String mailId = "";

  final Completer<GoogleMapController> mapCompleter =
      Completer<GoogleMapController>();

  static const CameraPosition cameraPosition = CameraPosition(
      target: LatLng(10.065010195176646, 76.35613924535859),
      zoom: 10 //increase to zoom
      );

  List<Stations> stationList = [];
  Position? position;
  GoogleMapController? mapController;
  RxList<UsageHistoryItem> usageHistoryList = RxList.empty(growable: true);
  final TextEditingController walletBalanceController = TextEditingController();
  String razorPayKey = 'rzp_test_OFcfkX8sEE8TOD';

  @override
  void onInit() async {
    setSelectedIndex(int.parse(
        (Get.parameters[ParamName.index] ?? stationIndex).toString()));
    super.onInit();
    walletBalanceController.text = '100';
    //  await determinePosition(); //to go to my location
    getStations();
    //getFavoritesList();
    getProfile();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  @override
  void onClose() {
    super.onClose();
    _razorpay.clear();
  }

  void openCheckout() async {
    int amount = int.parse(walletBalanceController.text) * 100;
    var options = {
      'key': razorPayKey,
      'amount': amount, //in the smallest currency sub-unit.
      'name': 'Next Power',
      //  'order_id': 'order_EMBFqjDHEEn80l', // Generate order_id using Orders API
      'description': 'Wallet Recharge',
      'timeout': 60, // in seconds
      'prefill': {'contact': phoneNumber.value, 'email': mailId}
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      print("Error :$e");
    }
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    CustomSnackBar.showIncompleteSnackBar(
        LocaleKeys.success.tr, "Payment success  ${response.paymentId}");
    print("payment id = ${response.paymentId}");
    print("orderId id = ${response.orderId}");
    print("signature id = ${response.signature}");
    print("data id = ${response.data}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    CustomSnackBar.showErrorSnackBar(
        LocaleKeys.error.tr, "Payment failed  ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    CustomSnackBar.showIncompleteSnackBar(
        LocaleKeys.success.tr, "Payment success  ${response.walletName}");
  }

  void getStations() {
    // isLoading(true);
    HomeStationsProvider()
        .getStations(
            latitude: cameraPosition.target.latitude,
            longitude: cameraPosition.target.longitude)
        .then((value) {
      //  isLoading(false);
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

  void getUsageHistory() {
    historyLoading(true);
    UsageHistoryProvider().getUsageHistory().then((value) {
      historyLoading(false);
      UsageHistoryResponse response = value;
      if (response.status ?? false) {
        usageHistoryList.value = response.usageHistory ?? [];
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
      getUsageHistory();
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

  Future<void> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
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
    FavoriteProvider().getFavoritesList().then((response) {
      if (response.status == true) {
        favoritesList.value = response.favorites!;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
      isLoading(false);
    });
  }

  void removeFavorite(int stationId) async {
    FavoriteProvider()
        .removeOrAddFavoritesListItem(favoriteId: 0, stationId: stationId)
        .then((response) {
      if (response.status == true) {
        CustomSnackBar.showSuccessSnackBar(
            LocaleKeys.success.tr, response.message ?? "");
        getFavoritesList();
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
    //  isLoading(false);
  }

  void getWalletData() async {
    isLoading(true);
    WalletDetailProvider().getWalletDetail().then((value) {
      if (value.status != null && value.status == true) {
        walletDetail.value = value;
      } else {
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, value.message ?? "");
      }
      isLoading(false);
    });
  }

  void setWalletAmountChosenIndex({required int index, required int amount}) {
    walletChosenAmountIndex(index);
    walletBalanceController.text = amount.toString();
  }

  void getProfile() {
    //isLoading(true);
    ProfileProvider().getProfile().then((response) {
      if (response.status ?? false) {
        name(response.profile?.name ?? "");
        phoneNumber(response.profile?.phoneNumber ?? "");
        mailId = response.profile?.userEmail ?? "";
        //isLoading(false);
      } else {
        //isLoading(false);
        CustomSnackBar.showErrorSnackBar(
            LocaleKeys.failed.tr, response.message ?? "");
      }
    });
  }
}
