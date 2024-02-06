class VehicleMakersResponse {
  VehicleMakersResponse({
      bool? status, 
      String? message, 
      List<Stations>? stations,}){
    _status = status;
    _message = message;
    _stations = stations;
}

  VehicleMakersResponse.fromJson(dynamic json) {
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
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  Stations.fromJson(dynamic json) {
    _id = json['id '];
    _title = json['title '];
  }
  num? _id;
  String? _title;

  num? get id => _id;
  String? get title => _title;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id '] = _id;
    map['title '] = _title;
    return map;
  }

}