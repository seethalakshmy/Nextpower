import 'dart:convert';

class RfidResponse {
  final bool? status;
  final String? message;
  final List<Rfid>? rfids;

  RfidResponse({
    this.status,
    this.message,
    this.rfids,
  });

  factory RfidResponse.fromRawJson(String str) => RfidResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory RfidResponse.fromJson(Map<String, dynamic> json) => RfidResponse(
    status: json["status"],
    message: json["message"],
    rfids: json["rfids"] == null ? [] : List<Rfid>.from(json["rfids"]!.map((x) => Rfid.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "rfids": rfids == null ? [] : List<dynamic>.from(rfids!.map((x) => x.toJson())),
  };
}

class Rfid {
  final int? id;
  final String? tagName;
  final String? tagIssuedDate;
  final String? tagStatus;

  Rfid({
    this.id,
    this.tagName,
    this.tagIssuedDate,
    this.tagStatus,
  });

  factory Rfid.fromRawJson(String str) => Rfid.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Rfid.fromJson(Map<String, dynamic> json) => Rfid(
    id: json["id "],
    tagName: json["tag_name"],
    tagIssuedDate: json["tag_issued_date"],
    tagStatus: json["tag_status"],
  );

  Map<String, dynamic> toJson() => {
    "id ": id,
    "tag_name": tagName,
    "tag_issued_date": tagIssuedDate,
    "tag_status": tagStatus,
  };
}
