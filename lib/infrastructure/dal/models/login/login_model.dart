
class LoginModel{
  bool? status;
  String? message;
  String? _name;
  String? _job;
  String? _id;
  String? _createdAt;

  LoginModel({String? name, String? job, String? id, String? createdAt,bool? statu,String? messag}) {
    if (name != null) {
      this._name = name;
    }
    if (job != null) {
      this._job = job;
    }
    if (id != null) {
      this._id = id;
    }
    if (createdAt != null) {
      this._createdAt = createdAt;
    }
    status = statu;
    message = messag;
  }

  String? get name => _name;
  set name(String? name) => _name = name;
  String? get job => _job;
  set job(String? job) => _job = job;
  String? get id => _id;
  set id(String? id) => _id = id;
  String? get createdAt => _createdAt;
  set createdAt(String? createdAt) => _createdAt = createdAt;

  LoginModel.fromJson(Map<String, dynamic> json) {
    _name = json['name'];
    _job = json['job'];
    _id = json['id'];
    _createdAt = json['createdAt'];
  }
}