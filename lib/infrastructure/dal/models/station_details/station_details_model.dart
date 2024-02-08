import 'dart:convert';

class StationDetailModel {
  final bool? status;
  final String? message;
  final Station? station;

  StationDetailModel({
    this.status,
    this.message,
    this.station,
  });

  factory StationDetailModel.fromRawJson(String str) => StationDetailModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory StationDetailModel.fromJson(Map<String, dynamic> json) => StationDetailModel(
    status: json["status"],
    message: json["message"],
    station: json["station"] == null ? null : Station.fromJson(json["station"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "station": station?.toJson(),
  };
}

class Station {
  final int? stationId;
  final String? stationName;
  final String? stationStatus;
  final int? freeConnectors;
  final int? activeConnectors;
  final int? power;
  final Overview? overview;
  final Address? address;
  final String? mailId;
  final List<String>? amenities;

  Station({
    this.stationId,
    this.stationName,
    this.stationStatus,
    this.freeConnectors,
    this.activeConnectors,
    this.power,
    this.overview,
    this.address,
    this.mailId,
    this.amenities,
  });

  factory Station.fromRawJson(String str) => Station.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Station.fromJson(Map<String, dynamic> json) => Station(
    stationId: json["station_id"],
    stationName: json["station_name"],
    stationStatus: json["station_status"],
    freeConnectors: json["free_connectors"],
    activeConnectors: json["active_connectors"],
    power: json["power"],
    overview: json["overview"] == null ? null : Overview.fromJson(json["overview"]),
    address: json["address"] == null ? null : Address.fromJson(json["address"]),
    mailId: json["mail_id"],
    amenities: json["amenities"] == null ? [] : List<String>.from(json["amenities"]!.map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "station_id": stationId,
    "station_name": stationName,
    "station_status": stationStatus,
    "free_connectors": freeConnectors,
    "active_connectors": activeConnectors,
    "power": power,
    "overview": overview?.toJson(),
    "address": address?.toJson(),
    "mail_id": mailId,
    "amenities": amenities == null ? [] : List<dynamic>.from(amenities!.map((x) => x)),
  };
}

class Address {
  final String? addressLine1;
  final String? addressLine2;
  final String? city;
  final int? stateId;
  final String? stateName;
  final String? postalCode;
  final int? countryId;
  final String? countryName;

  Address({
    this.addressLine1,
    this.addressLine2,
    this.city,
    this.stateId,
    this.stateName,
    this.postalCode,
    this.countryId,
    this.countryName,
  });

  factory Address.fromRawJson(String str) => Address.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Address.fromJson(Map<String, dynamic> json) => Address(
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

class Overview {
  final double? latitude;
  final double? longitude;
  final String? shareText;
  final String? mobileNumber;
  final String? openTime;
  final bool? isFavorite;

  Overview({
    this.latitude,
    this.longitude,
    this.shareText,
    this.mobileNumber,
    this.openTime,
    this.isFavorite,
  });

  factory Overview.fromRawJson(String str) => Overview.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
    latitude: json["latitude"]?.toDouble(),
    longitude: json["longitude"]?.toDouble(),
    shareText: json["share_text"],
    mobileNumber: json["mobile_number"],
    openTime: json["open_time"],
    isFavorite: json["is_favorite"],
  );

  Map<String, dynamic> toJson() => {
    "latitude": latitude,
    "longitude": longitude,
    "share_text": shareText,
    "mobile_number": mobileNumber,
    "open_time": openTime,
    "is_favorite": isFavorite,
  };
}
