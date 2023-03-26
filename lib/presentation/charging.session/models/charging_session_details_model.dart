class ChargingSessionDetails {
  String? stationName;
  String? chargingPointName;
  String? connectorName;
  String? connectorType;
  Pricing? pricing;
  String? kw;
  String? status;
  bool? hasReserve;
  int? chargeOption;
  String? chargeOptionValue;

  ChargingSessionDetails(
      {this.stationName,
      this.chargingPointName,
      this.connectorName,
      this.connectorType,
      this.pricing,
      this.kw,
      this.status,
      this.hasReserve,
      this.chargeOption,
      this.chargeOptionValue});

  ChargingSessionDetails.fromJson(Map<String, dynamic> json) {
    stationName = json['station_name'];
    chargingPointName = json['charging_point_name'];
    connectorName = json['connector_name'];
    connectorType = json['connector_type'];
    pricing =
        json['pricing'] != null ? Pricing?.fromJson(json['pricing']) : null;
    kw = json['kw'];
    status = json['status'];
    hasReserve = json['has_reserve'];
    chargeOption = json['charge_option'];
    chargeOptionValue = json['charge_option_value'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['station_name'] = stationName;
    data['charging_point_name'] = chargingPointName;
    data['connector_name'] = connectorName;
    data['connector_type'] = connectorType;
    if (pricing != null) {
      data['pricing'] = pricing?.toJson();
    }
    data['kw'] = kw;
    data['status'] = status;
    data['has_reserve'] = hasReserve;
    data['charge_option'] = chargeOption;
    data['charge_option_value'] = chargeOptionValue;
    return data;
  }
}

class Pricing {
  String? power;
  String? type;
  String? tariff;

  Pricing({this.power, this.type, this.tariff});

  Pricing.fromJson(Map<String, dynamic> json) {
    power = json['power'];
    type = json['type'];
    tariff = json['tariff'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['power'] = power;
    data['type'] = type;
    data['tariff'] = tariff;
    return data;
  }
}
