class StationsResponse {
  StationsResponse({
      bool? status, 
      String? message, 
      List<Stations>? stations,}){
    _status = status;
    _message = message;
    _stations = stations;
}

  StationsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['stations'] != null) {
      _stations = [];
      json['stations'].forEach((v) {
        _stations?.add(Stations.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Stations>? _stations;

  bool? get status => _status;
  String? get message => _message;
  List<Stations>? get stations => _stations;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_stations != null) {
      map['stations'] = _stations?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Stations {
  Stations({
      int? stationId,
    double? latitude,
    double? longitude,
    double? distance,
    int? freeConnectors,
    String? stationName,
    String? stationStatus,
    int? activeConnectors,
    num? power,}){
    _stationId = stationId;
    _latitude = latitude;
    _longitude = longitude;
    _distance = distance;
    _freeConnectors = freeConnectors;
    _stationName = stationName;
    _stationStatus = stationStatus;
    _activeConnectors = activeConnectors;
    _power = power;

}

  Stations.fromJson(dynamic json) {
    _stationId = json['station_id'];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _distance = json['distance'];
    _freeConnectors = json['free_connectors'];
    _stationName = json['station_name'];
    _stationStatus = json['station_status'];
    _activeConnectors = json['active_connectors'];
    _power = json['power'];
  }
  int? _stationId;
  double? _latitude;
  double? _longitude;
  double? _distance;
  int? _freeConnectors;
  String? _stationName;
  String? _stationStatus;
  int? _activeConnectors;
  num? _power;



  int? get stationId => _stationId;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  double? get distance => _distance;
  int? get freeConnectors => _freeConnectors;
  String? get stationName => _stationName;
  String? get stationStatus => _stationStatus;
  int? get activeConnectors => _activeConnectors;
  num? get power => _power;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id '] = _stationId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['distance'] = _distance;
    map['free_connectors'] = _freeConnectors;
    map['station_name '] = _stationName;
    map['station_status'] = _stationStatus;
    map['active_connectors'] = _activeConnectors;
    map['power'] = _power;
    return map;
  }

}