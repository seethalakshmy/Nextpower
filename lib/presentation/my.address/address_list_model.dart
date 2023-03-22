class AddressList {
  List<Address>? address;

  AddressList({this.address});

  AddressList.fromJson(Map<String, dynamic> json) {
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
  int? addressId;
  String? addressLine1;
  String? addressLine2;
  String? countryName;
  String? stateName;
  String? city;
  int? stateId;
  String? postalCode;
  int? countryId;
  String? companyName;
  String? gstNo;

  Address(
      {this.addressId,
      this.addressLine1,
      this.addressLine2,
      this.city,
      this.stateId,
      this.postalCode,
      this.countryId,
      this.companyName,
      this.gstNo});

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