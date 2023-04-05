class AboutUs {
  Address? address;
  String? openTime;
  String? mobileNumber;
  String? mailId;

  AboutUs({this.address, this.openTime, this.mobileNumber, this.mailId});

  AboutUs.fromJson(Map<String, dynamic> json) {
    address =
        json['address'] != null ? Address?.fromJson(json['address']) : null;
    openTime = json['open_time'];
    mobileNumber = json['mobile_number'];
    mailId = json['mail_id'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address?.toJson();
    }
    data['open_time'] = openTime;
    data['mobile_number'] = mobileNumber;
    data['mail_id'] = mailId;
    return data;
  }
}

class Address {
  int? addressId;
  String? addressLine1;
  String? addressLine2;
  String? city;
  int? stateId;
  String? postalCode;
  int? countryId;
  String? countryName;
  String? stateName;

  Address(
      {this.addressId,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.stateId,
      this.postalCode,
      this.countryId,
      this.countryName,
      this.stateName});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    stateId = json['state_id'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    stateName = json['state_name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state_id'] = stateId;
    data['postal_code'] = postalCode;
    data['country_id'] = countryId;
    data['company_name'] = countryName;
    data['gst_no'] = stateName;
    return data;
  }
}