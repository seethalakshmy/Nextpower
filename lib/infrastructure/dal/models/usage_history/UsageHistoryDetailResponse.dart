class UsageHistoryDetailResponse {
  UsageHistoryDetailResponse({
      bool? status, 
      String? message, 
      UsageHistory? usageHistory,}){
    _status = status;
    _message = message;
    _usageHistory = usageHistory;
}

  UsageHistoryDetailResponse.fromJson(dynamic json) {
    _status = json['status'];
    _message = json['message'];
    _usageHistory = json['usage_history'] != null ? UsageHistory.fromJson(json['usage_history']) : null;
  }
  bool? _status;
  String? _message;
  UsageHistory? _usageHistory;

  bool? get status => _status;
  String? get message => _message;
  UsageHistory? get usageHistory => _usageHistory;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = _status;
    map['message'] = _message;
    if (_usageHistory != null) {
      map['usage_history'] = _usageHistory?.toJson();
    }
    return map;
  }

}

class UsageHistory {
  UsageHistory({
      num? id, 
      num? totalCost, 
      String? totalUnit, 
      String? connector, 
      String? startTime, 
      String? endTime, 
      String? status, 
      String? transactionStatus,}){
    _id = id;
    _totalCost = totalCost;
    _totalUnit = totalUnit;
    _connector = connector;
    _startTime = startTime;
    _endTime = endTime;
    _status = status;
    _transactionStatus = transactionStatus;
}

  UsageHistory.fromJson(dynamic json) {
    _id = json['id'];
    _totalCost = json['total_cost'];
    _totalUnit = json['total_unit'];
    _connector = json['connector'];
    _startTime = json['start_time'];
    _endTime = json['end_time'];
    _status = json['status'];
    _transactionStatus = json['transaction_status'];
  }
  num? _id;
  num? _totalCost;
  String? _totalUnit;
  String? _connector;
  String? _startTime;
  String? _endTime;
  String? _status;
  String? _transactionStatus;

  num? get id => _id;
  num? get totalCost => _totalCost;
  String? get totalUnit => _totalUnit;
  String? get connector => _connector;
  String? get startTime => _startTime;
  String? get endTime => _endTime;
  String? get status => _status;
  String? get transactionStatus => _transactionStatus;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['total_cost'] = _totalCost;
    map['total_unit'] = _totalUnit;
    map['connector'] = _connector;
    map['start_time'] = _startTime;
    map['end_time'] = _endTime;
    map['status'] = _status;
    map['transaction_status'] = _transactionStatus;
    return map;
  }

}