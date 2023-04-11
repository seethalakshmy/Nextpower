class UsageHistoryList {
  List<UsageHistory>? usageHistory;

  UsageHistoryList({this.usageHistory});

  UsageHistoryList.fromJson(Map<String, dynamic> json) {
    if (json['usage_history'] != null) {
      usageHistory = <UsageHistory>[];
      json['usage_history'].forEach((v) {
        usageHistory?.add(UsageHistory.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (usageHistory != null) {
      data['usage_history'] = usageHistory?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class UsageHistory {
  int? id;
  double? totalCost;
  String? startTime;
  String? endTime;

  UsageHistory({this.id, this.totalCost, this.startTime, this.endTime});

  UsageHistory.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    totalCost = json['total_cost'];
    startTime = json['start_time'];
    endTime = json['end_time'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['total_cost'] = totalCost;
    data['start_time'] = startTime;
    data['end_time'] = endTime;
    return data;
  }
}
