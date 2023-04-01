class UsageHistoryDetails {
  int? id;
  double? totalCost;
  double? totalUnit;
  String? connector;
  String? startTime;
  String? endTime;
  String? status;
  String? transactionStatus;

  UsageHistoryDetails(
      {this.id,
      this.totalCost,
      this.totalUnit,
      this.connector,
      this.startTime,
      this.endTime,
      this.status,
      this.transactionStatus});

  UsageHistoryDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalCost = json['total_cost'];
    totalUnit = json['total_unit'];
    connector = json['connector'];
    startTime = json['start_time'];
    endTime = json['end_time'];
    status = json['status'];
    transactionStatus = json['transaction_status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['total_cost'] = totalCost;
    data['total_unit'] = totalUnit;
    data['connector'] = connector;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    data['status'] = status;
    data['transaction_status'] = transactionStatus;
    return data;
  }
}
