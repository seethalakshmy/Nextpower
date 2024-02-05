class VehicleListResponse {
  VehicleListResponse({
      bool? status, 
      String? message, 
      List<Vehicles>? vehicles,}){
    _status = status;
    _message = message;
    _vehicles = vehicles;
}

  VehicleListResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['vehicles'] != null) {
      _vehicles = [];
      json['vehicles'].forEach((v) {
        _vehicles?.add(Vehicles.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Vehicles>? _vehicles;

  bool? get status => _status;
  String? get message => _message;
  List<Vehicles>? get vehicles => _vehicles;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_vehicles != null) {
      map['vehicles'] = _vehicles?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Vehicles {
  Vehicles({
      int? id,
      num? userId, 
      String? vehicleNumber, 
      String? vehicleModel, 
      String? vehicleMake,}){
    _id = id;
    _userId = userId;
    _vehicleNumber = vehicleNumber;
    _vehicleModel = vehicleModel;
    _vehicleMake = vehicleMake;
}

  Vehicles.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _vehicleNumber = json['vehicle_number'];
    _vehicleModel = json['vehicle_model'];
    _vehicleMake = json['vehicle_make'];
  }
  int? _id;
  num? _userId;
  String? _vehicleNumber;
  String? _vehicleModel;
  String? _vehicleMake;

  int? get id => _id;
  num? get userId => _userId;
  String? get vehicleNumber => _vehicleNumber;
  String? get vehicleModel => _vehicleModel;
  String? get vehicleMake => _vehicleMake;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['vehicle_number'] = _vehicleNumber;
    map['vehicle_model'] = _vehicleModel;
    map['vehicle_make'] = _vehicleMake;
    return map;
  }

}