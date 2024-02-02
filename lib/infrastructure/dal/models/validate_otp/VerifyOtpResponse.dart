class VerifyOtpResponse {
  VerifyOtpResponse({
      bool? status, 
      String? message, 
      bool? isProfileCompleted, 
      String? tokenType, 
      String? accessToken, 
      num? userId, 
      String? name,}){
    _status = status;
    _message = message;
    _isProfileCompleted = isProfileCompleted;
    _tokenType = tokenType;
    _accessToken = accessToken;
    _userId = userId;
    _name = name;
}

  VerifyOtpResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _isProfileCompleted = json['is_profile_completed'];
    _tokenType = json['token_type'];
    _accessToken = json['access_token'];
    _userId = json['user_id'];
    _name = json['name'];
  }
  bool? _status;
  String? _message;
  bool? _isProfileCompleted;
  String? _tokenType;
  String? _accessToken;
  num? _userId;
  String? _name;

  bool? get status => _status;
  String? get message => _message;
  bool? get isProfileCompleted => _isProfileCompleted;
  String? get tokenType => _tokenType;
  String? get accessToken => _accessToken;
  num? get userId => _userId;
  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['is_profile_completed'] = _isProfileCompleted;
    map['token_type'] = _tokenType;
    map['access_token'] = _accessToken;
    map['user_id'] = _userId;
    map['name'] = _name;
    return map;
  }

}