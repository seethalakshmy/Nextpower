class StationsList {
  List<Station>? stationList;

  StationsList({this.stationList});

  StationsList.fromJson(Map<String, dynamic> json) {
    if (json['station_list'] != null) {
      stationList = <Station>[];
      json['station_list'].forEach((v) {
        stationList?.add(Station.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (stationList != null) {
      data['station_list'] = stationList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Station {
  int? stationId;
  String? stationName;
  String? lat;
  String? long;

  Station({this.stationId, this.stationName, this.lat, this.long});

  Station.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    stationName = json['station_name'];
    lat = json['lat'];
    long = json['long'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['station_name'] = stationName;
    data['lat'] = lat;
    data['long'] = long;
    return data;
  }
}