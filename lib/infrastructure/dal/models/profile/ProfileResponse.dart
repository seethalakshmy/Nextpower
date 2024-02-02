class ProfileResponse {
  ProfileResponse({
      bool? status, 
      String? message, 
      Profile? profile,}){
    _status = status;
    _message = message;
    _profile = profile;
}

  ProfileResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _profile = json['profile'] != null ? Profile.fromJson(json['profile']) : null;
  }
  bool? _status;
  String? _message;
  Profile? _profile;

  bool? get status => _status;
  String? get message => _message;
  Profile? get profile => _profile;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_profile != null) {
      map['profile'] = _profile?.toJson();
    }
    return map;
  }

}

class Profile {
  Profile({
      num? userId, 
      String? userImage, 
      String? name, 
      String? countryCode, 
      String? phoneNumber, 
      String? userEmail, 
      bool? isEmailVerified,}){
    _userId = userId;
    _userImage = userImage;
    _name = name;
    _countryCode = countryCode;
    _phoneNumber = phoneNumber;
    _userEmail = userEmail;
    _isEmailVerified = isEmailVerified;
}

  Profile.fromJson(dynamic json) {
    _userId = json['user_id'];
    _userImage = json['user_image'];
    _name = json['name'];
    _countryCode = json['country_code'];
    _phoneNumber = json['phone_number'];
    _userEmail = json['user_email'];
    _isEmailVerified = json['is_email_verified'];
  }
  num? _userId;
  String? _userImage;
  String? _name;
  String? _countryCode;
  String? _phoneNumber;
  String? _userEmail;
  bool? _isEmailVerified;

  num? get userId => _userId;
  String? get userImage => _userImage;
  String? get name => _name;
  String? get countryCode => _countryCode;
  String? get phoneNumber => _phoneNumber;
  String? get userEmail => _userEmail;
  bool? get isEmailVerified => _isEmailVerified;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['user_id'] = _userId;
    map['user_image'] = _userImage;
    map['name'] = _name;
    map['country_code'] = _countryCode;
    map['phone_number'] = _phoneNumber;
    map['user_email'] = _userEmail;
    map['is_email_verified'] = _isEmailVerified;
    return map;
  }

}