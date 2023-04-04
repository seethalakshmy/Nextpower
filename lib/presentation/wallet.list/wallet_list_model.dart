class WalletList {
  List<WalletHistory>? walletHistory;

  WalletList({this.walletHistory});

  WalletList.fromJson(Map<String, dynamic> json) {
    if (json['wallet_history'] != null) {
      walletHistory = <WalletHistory>[];
      json['wallet_history'].forEach((v) {
        walletHistory?.add(WalletHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (walletHistory != null) {
      data['wallet_history'] = walletHistory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class WalletHistory {
  int? walletId;
  String? type;
  String? mode;
  int? amount;
  String? date;

  WalletHistory({this.walletId, this.type, this.mode, this.amount, this.date});

  WalletHistory.fromJson(Map<String, dynamic> json) {
    walletId = json['wallet_id'];
    type = json['type'];
    mode = json['mode'];
    amount = json['amount'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['wallet_id'] = walletId;
    data['type'] = type;
    data['mode'] = mode;
    data['amount'] = amount;
    data['date'] = date;
    return data;
  }
}
