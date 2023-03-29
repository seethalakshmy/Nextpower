class FavoritesList {
  List<Favorites>? favorites;

  FavoritesList({this.favorites});

  FavoritesList.fromJson(Map<String, dynamic> json) {
    if (json['favorites'] != null) {
      favorites = <Favorites>[];
      json['favorites'].forEach((v) {
        favorites?.add(Favorites.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (favorites != null) {
      data['favorites'] = favorites?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Favorites {
  int? stationId;
  String? stationName;
  String? kwh;
  String? distance;
  double? lat;
  double? long;
  int? free;
  int? active;
  String? status;

  Favorites({this.stationId,
    this.stationName,
    this.kwh,
    this.distance,
    this.lat,
    this.long,
    this.free,
    this.active,
    this.status});

  Favorites.fromJson(Map<String, dynamic> json) {
    stationId = json['station_id'];
    stationName = json['station_name'];
    kwh = json['kwh'];
    distance = json['distance'];
    lat = json['lat'];
    long = json['long'];
    free = json['free'];
    active = json['active'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['station_id'] = stationId;
    data['station_name'] = stationName;
    data['kwh'] = kwh;
    data['distance'] = distance;
    data['lat'] = lat;
    data['long'] = long;
    data['free'] = free;
    data['active'] = active;
    data['status'] = status;
    return data;
  }
}