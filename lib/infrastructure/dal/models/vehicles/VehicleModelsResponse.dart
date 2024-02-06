class VehicleModelsResponse {
  VehicleModelsResponse({
      bool? status, 
      String? message, 
      List<ModelsItem>? stations,}){
    _status = status;
    _message = message;
    _stations = stations;
}

  VehicleModelsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['stations'] != null) {
      _stations = [];
      json['stations'].forEach((v) {
        _stations?.add(ModelsItem.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<ModelsItem>? _stations;

  bool? get status => _status;
  String? get message => _message;
  List<ModelsItem>? get stations => _stations;

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

class ModelsItem {
  ModelsItem({
      num? id, 
      String? name, 
      num? makeId,}){
    _id = id;
    _name = name;
    _makeId = makeId;
}

  ModelsItem.fromJson(dynamic json) {
    _id = json['id '];
    _name = json['name '];
    _makeId = json['make_id '];
  }
  num? _id;
  String? _name;
  num? _makeId;

  num? get id => _id;
  String? get name => _name;
  num? get makeId => _makeId;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id '] = _id;
    map['name '] = _name;
    map['make_id '] = _makeId;
    return map;
  }

}