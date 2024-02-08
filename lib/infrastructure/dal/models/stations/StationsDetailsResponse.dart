class StationsDetailsResponse {
  StationsDetailsResponse({
      bool? status, 
      String? message, 
      Station? station,}){
    _status = status;
    _message = message;
    _station = station;
}

  StationsDetailsResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _station = json['station'] != null ? Station.fromJson(json['station']) : null;
  }
  bool? _status;
  String? _message;
  Station? _station;

  bool? get status => _status;
  String? get message => _message;
  Station? get station => _station;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_station != null) {
      map['station'] = _station?.toJson();
    }
    return map;
  }

}

class Station {
  Station({
      int? stationId,
      String? stationName, 
      String? stationStatus, 
      Overview? overview, 
      Address? address, 
      String? mailId, 
      List<String>? amenities, 
      List<dynamic>? connectors,}){
    _stationId = stationId;
    _stationName = stationName;
    _stationStatus = stationStatus;
    _overview = overview;
    _address = address;
    _mailId = mailId;
    _amenities = amenities;
    _connectors = connectors;
}

  Station.fromJson(dynamic json) {
    _stationId = json['station_id'];
    _stationName = json['station_name'];
    _stationStatus = json['station_status'];
    _overview = json['overview'] != null ? Overview.fromJson(json['overview']) : null;
    _address = json['address'] != null ? Address.fromJson(json['address']) : null;
    _mailId = json['mail_id'];
    _amenities = json['amenities'] != null ? json['amenities'].cast<String>() : [];
    if (json['connectors'] != null) {
      _connectors = [];
    }
  }
  int? _stationId;
  String? _stationName;
  String? _stationStatus;
  Overview? _overview;
  Address? _address;
  String? _mailId;
  List<String>? _amenities;
  List<dynamic>? _connectors;

  int? get stationId => _stationId;
  String? get stationName => _stationName;
  String? get stationStatus => _stationStatus;
  Overview? get overview => _overview;
  Address? get address => _address;
  String? get mailId => _mailId;
  List<String>? get amenities => _amenities;
  List<dynamic>? get connectors => _connectors;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['station_id'] = _stationId;
    map['station_name'] = _stationName;
    map['station_status'] = _stationStatus;
    if (_overview != null) {
      map['overview'] = _overview?.toJson();
    }
    if (_address != null) {
      map['address'] = _address?.toJson();
    }
    map['mail_id'] = _mailId;
    map['amenities'] = _amenities;
    if (_connectors != null) {
      map['connectors'] = _connectors?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Address {
  Address({
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      num? stateId, 
      String? stateName, 
      String? postalCode, 
      num? countryId, 
      String? countryName,}){
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _stateId = stateId;
    _stateName = stateName;
    _postalCode = postalCode;
    _countryId = countryId;
    _countryName = countryName;
}

  Address.fromJson(dynamic json) {
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _stateId = json['state_id'];
    _stateName = json['state_name'];
    _postalCode = json['postal_code'];
    _countryId = json['country_id'];
    _countryName = json['country_name'];
  }
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  num? _stateId;
  String? _stateName;
  String? _postalCode;
  num? _countryId;
  String? _countryName;

  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  num? get stateId => _stateId;
  String? get stateName => _stateName;
  String? get postalCode => _postalCode;
  num? get countryId => _countryId;
  String? get countryName => _countryName;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state_id'] = _stateId;
    map['state_name'] = _stateName;
    map['postal_code'] = _postalCode;
    map['country_id'] = _countryId;
    map['country_name'] = _countryName;
    return map;
  }

}

class Overview {
  Overview({
      num? latitude, 
      num? longitude, 
      String? shareText, 
      String? mobileNumber, 
      String? openTime, 
      bool? isFavorite,}){
    _latitude = latitude;
    _longitude = longitude;
    _shareText = shareText;
    _mobileNumber = mobileNumber;
    _openTime = openTime;
    _isFavorite = isFavorite;
}

  Overview.fromJson(dynamic json) {
    _latitude = json['latitude'];
    _longitude = json['longitude'];
    _shareText = json['share_text'];
    _mobileNumber = json['mobile_number'];
    _openTime = json['open_time'];
    _isFavorite = json['is_favorite'];
  }
  num? _latitude;
  num? _longitude;
  String? _shareText;
  String? _mobileNumber;
  String? _openTime;
  bool? _isFavorite;

  num? get latitude => _latitude;
  num? get longitude => _longitude;
  String? get shareText => _shareText;
  String? get mobileNumber => _mobileNumber;
  String? get openTime => _openTime;
  bool? get isFavorite => _isFavorite;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['latitude'] = _latitude;
    map['longitude'] = _longitude;
    map['share_text'] = _shareText;
    map['mobile_number'] = _mobileNumber;
    map['open_time'] = _openTime;
    map['is_favorite'] = _isFavorite;
    return map;
  }

}