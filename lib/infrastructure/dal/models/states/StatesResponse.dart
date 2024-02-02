class StatesResponse {
  StatesResponse({
      bool? status, 
      String? message, 
      List<States>? states,}){
    _status = status;
    _message = message;
    _states = states;
}

  StatesResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['states'] != null) {
      _states = [];
      json['states'].forEach((v) {
        _states?.add(States.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<States>? _states;

  bool? get status => _status;
  String? get message => _message;
  List<States>? get states => _states;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_states != null) {
      map['states'] = _states?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class States {
  States({
      num? id, 
      String? name,}){
    _id = id;
    _name = name;
}

  States.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  num? _id;
  String? _name;

  num? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}