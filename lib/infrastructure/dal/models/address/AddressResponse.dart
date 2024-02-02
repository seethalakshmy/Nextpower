class AddressResponse {
  AddressResponse({
      bool? status, 
      String? message, 
      SavedAddress? savedAddress,}){
    _status = status;
    _message = message;
    _savedAddress = savedAddress;
}

  AddressResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _savedAddress = json['saved_address'] != null ? SavedAddress.fromJson(json['saved_address']) : null;
  }
  bool? _status;
  String? _message;
  SavedAddress? _savedAddress;

  bool? get status => _status;
  String? get message => _message;
  SavedAddress? get savedAddress => _savedAddress;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_savedAddress != null) {
      map['saved_address'] = _savedAddress?.toJson();
    }
    return map;
  }

}

class SavedAddress {
  SavedAddress({
      num? id, 
      num? userId, 
      String? addressLine1, 
      String? addressLine2, 
      String? city, 
      num? stateId, 
      String? postalCode, 
      num? countryId, 
      String? companyName, 
      String? gstNo,}){
    _id = id;
    _userId = userId;
    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _city = city;
    _stateId = stateId;
    _postalCode = postalCode;
    _countryId = countryId;
    _companyName = companyName;
    _gstNo = gstNo;
}

  SavedAddress.fromJson(dynamic json) {
    _id = json['id'];
    _userId = json['user_id'];
    _addressLine1 = json['address_line1'];
    _addressLine2 = json['address_line2'];
    _city = json['city'];
    _stateId = json['state_id'];
    _postalCode = json['postal_code'];
    _countryId = json['country_id'];
    _companyName = json['company_name'];
    _gstNo = json['gst_no'];
  }
  num? _id;
  num? _userId;
  String? _addressLine1;
  String? _addressLine2;
  String? _city;
  num? _stateId;
  String? _postalCode;
  num? _countryId;
  String? _companyName;
  String? _gstNo;

  num? get id => _id;
  num? get userId => _userId;
  String? get addressLine1 => _addressLine1;
  String? get addressLine2 => _addressLine2;
  String? get city => _city;
  num? get stateId => _stateId;
  String? get postalCode => _postalCode;
  num? get countryId => _countryId;
  String? get companyName => _companyName;
  String? get gstNo => _gstNo;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['user_id'] = _userId;
    map['address_line1'] = _addressLine1;
    map['address_line2'] = _addressLine2;
    map['city'] = _city;
    map['state_id'] = _stateId;
    map['postal_code'] = _postalCode;
    map['country_id'] = _countryId;
    map['company_name'] = _companyName;
    map['gst_no'] = _gstNo;
    return map;
  }

}