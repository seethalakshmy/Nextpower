import 'dart:convert';

class WalletHistoryResponseModel {
  final bool? status;
  final String? message;
  final List<WalletHistory>? walletHistory;

  WalletHistoryResponseModel({
    this.status,
    this.message,
    this.walletHistory,
  });

  factory WalletHistoryResponseModel.fromRawJson(String str) => WalletHistoryResponseModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletHistoryResponseModel.fromJson(Map<String, dynamic> json) => WalletHistoryResponseModel(
    status: json["status"],
    message: json["message"],
    walletHistory: json["wallet_history"] == null ? [] : List<WalletHistory>.from(json["wallet_history"]!.map((x) => WalletHistory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "wallet_history": walletHistory == null ? [] : List<dynamic>.from(walletHistory!.map((x) => x.toJson())),
  };
}

class WalletHistory {
  final int? id;
  final String? type;
  final String? mode;
  final int? amount;
  final String? date;

  WalletHistory({
    this.id,
    this.type,
    this.mode,
    this.amount,
    this.date,
  });

  factory WalletHistory.fromRawJson(String str) => WalletHistory.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory WalletHistory.fromJson(Map<String, dynamic> json) => WalletHistory(
    id: json["id "],
    type: json["type"],
    mode: json["mode"],
    amount: json["amount"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id ": id,
    "type": type,
    "mode": mode,
    "amount": amount,
    "date": date,
  };
}
