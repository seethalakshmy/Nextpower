class StationsList {
  List<Stations>? stations;

  StationsList({this.stations});

  StationsList.fromJson(Map<String, dynamic> json) {
    if (json['stations'] != null) {
      stations = <Stations>[];
      json['stations'].forEach((v) {
        stations?.add(Stations.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (stations != null) {
      data['stations'] = stations?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Stations {
  int? stationId;
  String? stationName;
  String? lat;
  String? long;
  String? kwh;
  String? distance;
  int? free;
  int? active;
  String? status;

  Stations(
      {this.stationId,
      this.stationName,
      this.lat,
      this.long,
      this.kwh,
      this.distance,
      this.free,
      this.active,
      this.status});

  Stations.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    stationName = json['station_name'];
    lat = json['lat'];
    long = json['long'];
    kwh = json['kwh'];
    distance = json['distance'];
    free = json['free'];
    active = json['active'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['station_name'] = stationName;
    data['lat'] = lat;
    data['long'] = long;
    data['kwh'] = kwh;
    data['distance'] = distance;
    data['free'] = free;
    data['active'] = active;
    data['status'] = status;
    return data;
  }
}
