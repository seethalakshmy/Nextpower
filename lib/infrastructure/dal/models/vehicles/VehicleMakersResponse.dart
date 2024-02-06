class VehicleMakersResponse {
  VehicleMakersResponse({
      bool? status, 
      String? message, 
      List<MakersItem>? stations,}){
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
        _stations?.add(MakersItem.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<MakersItem>? _stations;

  bool? get status => _status;
  String? get message => _message;
  List<MakersItem>? get stations => _stations;

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

class MakersItem {
  MakersItem({
      num? id, 
      String? title,}){
    _id = id;
    _title = title;
}

  MakersItem.fromJson(dynamic json) {
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