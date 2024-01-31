class LoginResponse {
  LoginResponse({
      bool? status, 
      String? message, 
      String? otp,}){
    _status = status;
    _message = message;
    _otp = otp;
}

  LoginResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _otp = json['otp'];
  }
  bool? _status;
  String? _message;
  String? _otp;

  bool? get status => _status;
  String? get message => _message;
  String? get otp => _otp;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    map['otp'] = _otp;
    return map;
  }

}