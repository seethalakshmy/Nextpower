class StateList {
  bool? status;
  String? message;
  List<States>? states;

  StateList({this.status, this.message, this.states});

  StateList.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    if (json['states'] != null) {
      states = <States>[];
      json['states'].forEach((v) {
        states?.add(States.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (states != null) {
      data['states'] = states?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class States {
  int? id;
  String? name;

  States({this.id, this.name});

  States.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    return data;
  }
}
