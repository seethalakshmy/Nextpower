class VehiclesList {
  List<Vehicles>? vehicles;

  VehiclesList({this.vehicles});

  VehiclesList.fromJson(Map<String, dynamic> json) {
    if (json['vehicles'] != null) {
      vehicles = <Vehicles>[];
      json['vehicles'].forEach((v) {
        vehicles?.add(Vehicles.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (vehicles != null) {
      data['vehicles'] = vehicles?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Vehicles {
  int? vehicleId;
  String? vehicleNumber;
  String? vehicleMake;
  String? vehicleModel;

  Vehicles({this.vehicleNumber, this.vehicleMake, this.vehicleModel});

  Vehicles.fromJson(Map<String, dynamic> json) {
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