class ConnectorsResponse {
  ConnectorsResponse({
      bool? status, 
      String? message, 
      List<Connectors>? connectors,}){
    _status = status;
    _message = message;
    _connectors = connectors;
}

  ConnectorsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['connectors'] != null) {
      _connectors = [];
      json['connectors'].forEach((v) {
        _connectors?.add(Connectors.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Connectors>? _connectors;

  bool? get status => _status;
  String? get message => _message;
  List<Connectors>? get connectors => _connectors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_connectors != null) {
      map['connectors'] = _connectors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Connectors {
  Connectors({
      num? connectorId, 
      String? chargingPointName, 
      String? kw, 
      String? status, 
      String? connectorName, 
      String? connectorType, 
      String? tariff, 
      bool? hasReserve,}){
    _connectorId = connectorId;
    _chargingPointName = chargingPointName;
    _kw = kw;
    _status = status;
    _connectorName = connectorName;
    _connectorType = connectorType;
    _tariff = tariff;
    _hasReserve = hasReserve;
}

  Connectors.fromJson(dynamic json) {
    _connectorId = json['connector_id'];
    _chargingPointName = json['charging_point_name'];
    _kw = json['kw'];
    _status = json['status'];
    _connectorName = json['connector_name'];
    _connectorType = json['connector_type'];
    _tariff = json['tariff'];
    _hasReserve = json['has_reserve'];
  }
  num? _connectorId;
  String? _chargingPointName;
  String? _kw;
  String? _status;
  String? _connectorName;
  String? _connectorType;
  String? _tariff;
  bool? _hasReserve;

  num? get connectorId => _connectorId;
  String? get chargingPointName => _chargingPointName;
  String? get kw => _kw;
  String? get status => _status;
  String? get connectorName => _connectorName;
  String? get connectorType => _connectorType;
  String? get tariff => _tariff;
  bool? get hasReserve => _hasReserve;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['connector_id'] = _connectorId;
    map['charging_point_name'] = _chargingPointName;
    map['kw'] = _kw;
    map['status'] = _status;
    map['connector_name'] = _connectorName;
    map['connector_type'] = _connectorType;
    map['tariff'] = _tariff;
    map['has_reserve'] = _hasReserve;
    return map;
  }

}