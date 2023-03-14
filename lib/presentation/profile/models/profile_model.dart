class Profile {
  int? userId;
  String? userName;
  String? countryCode;
  String? mobileNumber;
  String? emailId;
  bool? isEmailVerified;
  String? userImage;

  Profile(
      {this.userId,
      this.userName,
      this.countryCode,
      this.mobileNumber,
      this.emailId,
      this.isEmailVerified,
      this.userImage});

  Profile.fromJson(Map<String, dynamic> json) {
    userId = json['user_id'];
    userName = json['user_name'];
    countryCode = json['country_code'];
    mobileNumber = json['mobile_number'];
    emailId = json['email_id'];
    isEmailVerified = json['is_email_verified'];
    userImage = json['user_image'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['user_id'] = userId;
    data['user_name'] = userName;
    data['country_code'] = countryCode;
    data['mobile_number'] = mobileNumber;
    data['email_id'] = emailId;
    data['is_email_verified'] = isEmailVerified;
    data['user_image'] = userImage;
    return data;
  }
}
