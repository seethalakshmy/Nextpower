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
      num? stationId,
    double? latitude,
    double? longitude,
    double? distance,}){
    _stationId = stationId;
    _latitude = latitude;
    _longitude = longitude;
    _distance = distance;
}

  Stations.fromJson(dynamic json) {
    _stationId = json['station_id '];
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _distance = json['distance'];
  }
  num? _stationId;
  double? _latitude;
  double? _longitude;
  double? _distance;

  num? get stationId => _stationId;
  double? get latitude => _latitude;
  double? get longitude => _longitude;
  double? get distance => _distance;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id '] = _stationId;
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['distance'] = _distance;
    return map;
  }

}