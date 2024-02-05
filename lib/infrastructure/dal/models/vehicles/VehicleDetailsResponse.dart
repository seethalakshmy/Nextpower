class VehicleDetailsResponse {
  VehicleDetailsResponse({
      bool? status, 
      String? message, 
      Vehicle? vehicle,}){
    _status = status;
    _message = message;
    _vehicle = vehicle;
}

  VehicleDetailsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _vehicle = json['vehicle'] != null ? Vehicle.fromJson(json['vehicle']) : null;
  }
  bool? _status;
  String? _message;
  Vehicle? _vehicle;

  bool? get status => _status;
  String? get message => _message;
  Vehicle? get vehicle => _vehicle;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_vehicle != null) {
      map['vehicle'] = _vehicle?.toJson();
    }
    return map;
  }

}

class Vehicle {
  Vehicle({
      num? id, 
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

  Vehicle.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _vehicleNumber = json['vehicle_number'];
    _vehicleModel = json['vehicle_model'];
    _vehicleMake = json['vehicle_make'];
  }
  num? _id;
  num? _userId;
  String? _vehicleNumber;
  String? _vehicleModel;
  String? _vehicleMake;

  num? get id => _id;
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