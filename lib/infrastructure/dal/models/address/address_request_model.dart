class AddressRequest {
  List<Address>? address;

  AddressRequest({this.address});

  AddressRequest.fromJson(Map<String, dynamic> json) {
    if (json['address'] != null) {
      address = <Address>[];
      json['address'].forEach((v) {
        address?.add(Address.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (address != null) {
      data['address'] = address?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Address {
  int? addressId = 0;
  String addressLine1 = "";
  String addressLine2 = "";
  String countryName = "";
  String stateName = "";
  String city = "";
  int stateId = 0;
  String postalCode = "";
  int countryId = 0;
  String companyName = "";
  String gstNo = "";

  Address(
      {this.addressId,
      this.addressLine1 = "",
      this.addressLine2 = "",
      this.city = "",
      this.stateId = 0,
      this.postalCode = "",
      this.countryId = 0,
      this.companyName = "",
        this.countryName = "",
        this.stateName = "",
      this.gstNo = ""});

  Address.fromJson(Map<String, dynamic> json) {
    addressId = json['address_id'];
    addressLine1 = json['address_line1'];
    addressLine2 = json['address_line2'];
    city = json['city'];
    stateId = json['state_id'];
    stateName = json['state_name'];
    postalCode = json['postal_code'];
    countryId = json['country_id'];
    countryName = json['country_name'];
    companyName = json['company_name'];
    gstNo = json['gst_no'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['address_id'] = addressId;
    data['address_line1'] = addressLine1;
    data['address_line2'] = addressLine2;
    data['city'] = city;
    data['state_id'] = stateId;
    data['state_name'] = stateName;
    data['postal_code'] = postalCode;
    data['country_id'] = countryId;
    data['country_name'] = countryName;
    data['company_name'] = companyName;
    data['gst_no'] = gstNo;
    return data;
  }
}