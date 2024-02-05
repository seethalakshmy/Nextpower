class StatesResponse {
  StatesResponse({
      bool? status, 
      String? message, 
      List<CountryState>? states,}){
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
        _states?.add(CountryState.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<CountryState>? _states;

  bool? get status => _status;
  String? get message => _message;
  List<CountryState>? get states => _states;

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

class CountryState {
  CountryState({
      int? id,
      String? name,}){
    _id = id;
    _name = name;
}

  CountryState.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }
  int? _id;
  String? _name;

  int? get id => _id;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }

}