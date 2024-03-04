
import 'dart:convert';

FavoritesModelResponse favoritesModelResponseFromJson(String str) => FavoritesModelResponse.fromJson(json.decode(str));

String favoritesModelResponseToJson(FavoritesModelResponse data) => json.encode(data.toJson());

class FavoritesModelResponse {
  final bool status;
  final String message;
  final List<Favorite> favorites;

  FavoritesModelResponse({
    required this.status,
    required this.message,
    required this.favorites,
  });

  factory FavoritesModelResponse.fromJson(Map<String, dynamic> json) => FavoritesModelResponse(
    status: json["status"],
    message: json["message"],
    favorites: List<Favorite>.from(json["favorites"].map((x) => Favorite.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "favorites": List<dynamic>.from(favorites.map((x) => x.toJson())),
  };
}

class Favorite {
  final int stationId;
  final String stationName;
  final String stationStatus;
  final int freeConnectors;
  final int activeConnectors;
  final double latitude;
  final double longitude;
  final StationAddress stationAddress;

  Favorite({
    required this.stationId,
    required this.stationName,
    required this.stationStatus,
    required this.freeConnectors,
    required this.activeConnectors,
    required this.latitude,
    required this.longitude,
    required this.stationAddress,
  });

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
    stationId: json["station_id"],
    stationName: json["station_name"],
    stationStatus: json["station_status"],
    freeConnectors: json["free_connectors"],
    activeConnectors: json["active_connectors"],
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    stationAddress: StationAddress.fromJson(json["station_address"]),
  );

  Map<String, dynamic> toJson() => {
    "station_id": stationId,
    "station_name": stationName,
    "station_status": stationStatus,
    "free_connectors": freeConnectors,
    "active_connectors": activeConnectors,
    "latitude": latitude,
    "longitude": longitude,
    "station_address": stationAddress.toJson(),
  };
}

class StationAddress {
  final String addressLine1;
  final String addressLine2;
  final String city;
  final int stateId;
  final String stateName;
  final String postalCode;
  final int countryId;
  final String countryName;

  StationAddress({
    required this.addressLine1,
    required this.addressLine2,
    required this.city,
    required this.stateId,
    required this.stateName,
    required this.postalCode,
    required this.countryId,
    required this.countryName,
  });

  factory StationAddress.fromJson(Map<String, dynamic> json) => StationAddress(
    addressLine1: json["address_line1"],
    addressLine2: json["address_line2"],
    city: json["city"],
    stateId: json["state_id"],
    stateName: json["state_name"],
    postalCode: json["postal_code"],
    countryId: json["country_id"],
    countryName: json["country_name"],
  );

  Map<String, dynamic> toJson() => {
    "address_line1": addressLine1,
    "address_line2": addressLine2,
    "city": city,
    "state_id": stateId,
    "state_name": stateName,
    "postal_code": postalCode,
    "country_id": countryId,
    "country_name": countryName,
  };
}
