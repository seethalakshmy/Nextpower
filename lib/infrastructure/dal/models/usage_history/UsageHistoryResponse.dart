class UsageHistoryResponse {
  UsageHistoryResponse({
      bool? status, 
      String? message, 
      List<UsageHistoryItem>? usageHistory,}){
    _status = status;
    _message = message;
    _usageHistory = usageHistory;
}

  UsageHistoryResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    if (json['usage_history'] != null) {
      _usageHistory = [];
      json['usage_history'].forEach((v) {
        _usageHistory?.add(UsageHistoryItem.fromJson(v));
      });
    }
  }
  bool? _status;
  String? _message;
  List<UsageHistoryItem>? _usageHistory;

  bool? get status => _status;
  String? get message => _message;
  List<UsageHistoryItem>? get usageHistory => _usageHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_usageHistory != null) {
      map['usage_history'] = _usageHistory?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class UsageHistoryItem {
  UsageHistoryItem({
      num? id, 
      String? startTime, 
      String? endTime, 
      num? totalCost,}){
    _id = id;
    _startTime = startTime;
    _endTime = endTime;
    _totalCost = totalCost;
}

  UsageHistoryItem.fromJson(dynamic json) {
    _id = json['id '];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _totalCost = json['total_cost'];
  }
  num? _id;
  String? _startTime;
  String? _endTime;
  num? _totalCost;

  num? get id => _id;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  num? get totalCost => _totalCost;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id '] = _id;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['total_cost'] = _totalCost;
    return map;
  }

}