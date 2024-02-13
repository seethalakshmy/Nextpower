import 'dart:convert';

class ChargingSessionResponseModel {
  final bool? status;
  final String? message;
  final ChargingSession? chargingSession;

  ChargingSessionResponseModel({
    this.status,
    this.message,
    this.chargingSession,
  });

  factory ChargingSessionResponseModel.fromRawJson(String str) => ChargingSessionResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargingSessionResponseModel.fromJson(Map<String, dynamic> json) => ChargingSessionResponseModel(
    status: json["status"],
    message: json["message"],
    chargingSession: json["charging_session"] == null ? null : ChargingSession.fromJson(json["charging_session"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "charging_session": chargingSession?.toJson(),
  };
}

class ChargingSession {
  final String? stationName;
  final String? chargingPointName;
  final String? connectorName;
  final String? connectorType;
  final String? status;
  final Pricing? pricing;
  final String? kw;
  final bool? hasReserve;
  final int? chargeOption;
  final String? chargeOptionValue;

  ChargingSession({
    this.stationName,
    this.chargingPointName,
    this.connectorName,
    this.connectorType,
    this.status,
    this.pricing,
    this.kw,
    this.hasReserve,
    this.chargeOption,
    this.chargeOptionValue,
  });

  factory ChargingSession.fromRawJson(String str) => ChargingSession.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ChargingSession.fromJson(Map<String, dynamic> json) => ChargingSession(
    stationName: json["station_name"],
    chargingPointName: json["charging_point_name"],
    connectorName: json["connector_name"],
    connectorType: json["connector_type"],
    status: json["status"],
    pricing: json["pricing"] == null ? null : Pricing.fromJson(json["pricing"]),
    kw: json["kw"],
    hasReserve: json["has_reserve"],
    chargeOption: json["charge_option"],
    chargeOptionValue: json["charge_option_value"],
  );

  Map<String, dynamic> toJson() => {
    "station_name": stationName,
    "charging_point_name": chargingPointName,
    "connector_name": connectorName,
    "connector_type": connectorType,
    "status": status,
    "pricing": pricing?.toJson(),
    "kw": kw,
    "has_reserve": hasReserve,
    "charge_option": chargeOption,
    "charge_option_value": chargeOptionValue,
  };
}

class Pricing {
  final String? power;
  final String? type;
  final String? tariff;

  Pricing({
    this.power,
    this.type,
    this.tariff,
  });

  factory Pricing.fromRawJson(String str) => Pricing.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Pricing.fromJson(Map<String, dynamic> json) => Pricing(
    power: json["power"],
    type: json["type"],
    tariff: json["tariff"],
  );

  Map<String, dynamic> toJson() => {
    "power": power,
    "type": type,
    "tariff": tariff,
  };
}
