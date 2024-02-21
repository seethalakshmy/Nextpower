import 'dart:convert';

VersionDetailResponseModel versionDetailResponseModelFromJson(String str) =>
    VersionDetailResponseModel.fromJson(json.decode(str));

String versionDetailResponseModelToJson(VersionDetailResponseModel data) =>
    json.encode(data.toJson());

class VersionDetailResponseModel {
  bool? status;
  String? message;
  AppVersions? appVersions;

  VersionDetailResponseModel({
    this.status,
    this.message,
    this.appVersions,
  });

  factory VersionDetailResponseModel.fromJson(Map<String, dynamic> json) =>
      VersionDetailResponseModel(
        status: json["status"],
        message: json["message"],
        appVersions: json["app_versions"] == null
            ? null
            : AppVersions.fromJson(json["app_versions"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "app_versions": appVersions?.toJson(),
      };
}

class AppVersions {
  Android? ios;
  Android? android;

  AppVersions({
    this.ios,
    this.android,
  });

  factory AppVersions.fromJson(Map<String, dynamic> json) => AppVersions(
        ios: json["ios"] == null ? null : Android.fromJson(json["ios"]),
        android:
            json["android"] == null ? null : Android.fromJson(json["android"]),
      );

  Map<String, dynamic> toJson() => {
        "ios": ios?.toJson(),
        "android": android?.toJson(),
      };
}

class Android {
  int? id;
  String? version;
  DateTime? releaseDate;
  String? notes;
  String? updateType;

  Android({
    this.id,
    this.version,
    this.releaseDate,
    this.notes,
    this.updateType,
  });

  factory Android.fromJson(Map<String, dynamic> json) => Android(
        id: json["id"],
        version: json["version"],
        releaseDate: json["release_date"] == null
            ? null
            : DateTime.parse(json["release_date"]),
        notes: json["notes"],
        updateType: json["update_type"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "version": version,
        "release_date":
            "${releaseDate!.year.toString().padLeft(4, '0')}-${releaseDate!.month.toString().padLeft(2, '0')}-${releaseDate!.day.toString().padLeft(2, '0')}",
        "notes": notes,
        "update_type": updateType,
      };
}
