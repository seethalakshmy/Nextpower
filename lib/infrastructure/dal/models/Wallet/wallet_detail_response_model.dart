import 'dart:convert';

class WalletDetailResponseModel {
  final bool? status;
  final String? message;
  final Wallet? wallet;

  WalletDetailResponseModel({
    this.status,
    this.message,
    this.wallet,
  });

  factory WalletDetailResponseModel.fromRawJson(String str) => WalletDetailResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletDetailResponseModel.fromJson(Map<String, dynamic> json) => WalletDetailResponseModel(
    status: json["status"],
    message: json["message"],
    wallet: json["wallet"] == null ? null : Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "wallet": wallet?.toJson(),
  };
}

class Wallet {
  final int? availableAmount;

  Wallet({
    this.availableAmount,
  });

  factory Wallet.fromRawJson(String str) => Wallet.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    availableAmount: json["available_amount"],
  );

  Map<String, dynamic> toJson() => {
    "available_amount": availableAmount,
  };
}
