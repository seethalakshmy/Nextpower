

class RegistrationModel {
  int? userId;
  String? userName;
  String userNameError = "";
  String mobileNumberError = "";
  String emailError = "";
  String? countryCode;
  String? mobileNumber;
  String? emailId;

  RegistrationModel(
      {this.userId,
      this.userName,
      this.countryCode,
      this.mobileNumber,
      this.emailId});

  RegistrationModel.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['email_id'] = emailId;
    return data;
  }
}