class WalletDetail {
  Wallet? wallet;

  WalletDetail({this.wallet});

  WalletDetail.fromJson(Map<String, dynamic> json) {
    wallet = json['wallet'] != null ? Wallet?.fromJson(json['wallet']) : null;
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (wallet != null) {
      data['wallet'] = wallet?.toJson();
    }
    return data;
  }
}

class Wallet {
  double? availableBalance;
  List<int>? amountList;

  Wallet({this.availableBalance, this.amountList});

  Wallet.fromJson(Map<String, dynamic> json) {
    availableBalance = json['available_balance'];
    amountList = json['amount_list'].cast<int>();
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['available_balance'] = availableBalance;
    data['amount_list'] = amountList;
    return data;
  }
}