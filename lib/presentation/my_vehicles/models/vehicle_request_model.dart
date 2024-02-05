
class VehicleRequest {
  int? vehicleId;
  String vehicleNumber = "";
  String vehicleMake = "";
  String vehicleModel = "";

  VehicleRequest({this.vehicleNumber = "", this.vehicleMake = "", this.vehicleModel = ""});

  VehicleRequest.fromJson(Map<String, dynamic> json) {
    vehicleId = json['vehicle_id'];
    vehicleNumber = json['vehicle_number'];
    vehicleMake = json['vehicle_make'];
    vehicleModel = json['vehicle_model'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['vehicle_id'] = vehicleId;
    data['vehicle_number'] = vehicleNumber;
    data['vehicle_make'] = vehicleMake;
    data['vehicle_model'] = vehicleModel;
    return data;
  }
}