class StationDetails {
  int? stationId;
  String? stationName;
  String? stationStatus;
  Overview? overview;
  List<ConnectorsList>? connectorsList;

  StationDetails({this.stationId,
    this.stationName,
    this.stationStatus,
    this.overview,
    this.connectorsList});

  StationDetails.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    stationName = json['station_name'];
    stationStatus = json['station_status'];
    overview =
    json['overview'] != null ? Overview?.fromJson(json['overview']) : null;
    if (json['connectors_list'] != null) {
      connectorsList = <ConnectorsList>[];
      json['connectors_list'].forEach((v) {
        connectorsList?.add(ConnectorsList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['station_name'] = stationName;
    data['station_status'] = stationStatus;
    if (overview != null) {
      data['overview'] = overview?.toJson();
    }
    if (connectorsList != null) {
      data['connectors_list'] = connectorsList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Overview {
  String? lat;
  String? long;
  String? shareText;
  String? mobileNumber;
  bool? isFavorite;
  String? address;
  String? mailId;
  List<String>? amenities;

  Overview({this.lat,
    this.long,
    this.shareText,
    this.mobileNumber,
    this.isFavorite,
    this.address,
    this.mailId,
    this.amenities});

  Overview.fromJson(Map<String, dynamic> json) {
    lat = json['lat'];
    long = json['long'];
    shareText = json['share_text'];
    mobileNumber = json['mobile_number'];
    isFavorite = json['is_favorite'];
    address = json['address'];
    mailId = json['mail_id'];
    amenities = json['amenities'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['lat'] = lat;
    data['long'] = long;
    data['share_text'] = shareText;
    data['mobile_number'] = mobileNumber;
    data['is_favorite'] = isFavorite;
    data['address'] = address;
    data['mail_id'] = mailId;
    data['amenities'] = amenities;
    return data;
  }
}

class ConnectorsList {
  int? connectorId;
  String? chargingPointName;
  String? kw;
  String? status;
  String? connectorName;
  String? connectorType;
  String? tariff;
  bool? hasReserve;

  ConnectorsList({this.connectorId,
    this.chargingPointName,
    this.kw,
    this.status,
    this.connectorName,
    this.tariff,
    this.hasReserve});

  ConnectorsList.fromJson(Map<String, dynamic> json) {
    connectorId = json['connector_id'];
    chargingPointName = json['charging_point_name'];
    kw = json['kw'];
    status = json['status'];
    connectorName = json['connector_name'];
    connectorType = json['connector_type'];
    tariff = json['tariff'];
    hasReserve = json['has_reserve'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['connector_id'] = connectorId;
    data['charging_point_name'] = chargingPointName;
    data['kw'] = kw;
    data['status'] = status;
    data['connector_name'] = connectorName;
    data['connector_type'] = connectorType;
    data['tariff'] = tariff;
    data['has_reserve'] = hasReserve;
    return data;
  }
}