class CountryResponse {
  CountryResponse({
      bool? status, 
      String? message, 
      List<Country>? countries,}){
    _status = status;
    _message = message;
    _countries = countries;
}

  CountryResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['countries'] != null) {
      _countries = [];
      json['countries'].forEach((v) {
        _countries?.add(Country.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<Country>? _countries;

  bool? get status => _status;
  String? get message => _message;
  List<Country>? get countries => _countries;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_countries != null) {
      map['countries'] = _countries?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Country {
  Country({
      num? id, 
      String? name, 
      num? countryCode,}){
    _id = id;
    _name = name;
    _countryCode = countryCode;
}

  Country.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _countryCode = json['country_code'];
  }
  num? _id;
  String? _name;
  num? _countryCode;

  num? get id => _id;
  String? get name => _name;
  num? get countryCode => _countryCode;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['country_code'] = _countryCode;
    return map;
  }

}