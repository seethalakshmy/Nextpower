import 'dart:convert';

class FavoritesModelResponse {
  final bool? status;
  final String? message;
  final List<Favorite>? favorites;

  FavoritesModelResponse({
    this.status,
    this.message,
    this.favorites,
  });

  factory FavoritesModelResponse.fromRawJson(String str) =>
      FavoritesModelResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory FavoritesModelResponse.fromJson(Map<String, dynamic> json) =>
      FavoritesModelResponse(
        status: json["status"],
        message: json["message"],
        favorites: json["favorites"] == null
            ? []
            : List<Favorite>.from(
                json["favorites"]!.map((x) => Favorite.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "favorites": favorites == null
            ? []
            : List<dynamic>.from(favorites!.map((x) => x.toJson())),
      };
}

class Favorite {
  final int? stationId;
  final double? latitude;
  final String? stationName;
  final String? stationStatus;
  final int? freeConnectors;
  final int? activeConnectors;
  final double? longitude;

  Favorite({
    this.stationId,
    this.latitude,
    this.stationName,
    this.stationStatus,
    this.freeConnectors,
    this.activeConnectors,
    this.longitude,
  });

  factory Favorite.fromRawJson(String str) =>
      Favorite.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Favorite.fromJson(Map<String, dynamic> json) => Favorite(
        stationId: json["station_id"],
        latitude: json["latitude"]?.toDouble(),
        stationName: json["station_name"],
        stationStatus: json["station_status"],
        freeConnectors: json["free_connectors"],
        activeConnectors: json["active_connectors"],
        longitude: json["longitude"]?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        "station_id": stationId,
        "latitude": latitude,
        "station_name": stationName,
        "station_status": stationStatus,
        "free_connectors": freeConnectors,
        "active_connectors": activeConnectors,
        "longitude": longitude,
      };
}
