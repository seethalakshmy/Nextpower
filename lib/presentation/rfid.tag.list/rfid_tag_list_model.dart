import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class RfidTagList {
  List<RfidItem>? rfidList;

  RfidTagList({this.rfidList});

  RfidTagList.fromJson(Map<String, dynamic> json) {
    if (json['rfid_list'] != null) {
      rfidList = <RfidItem>[];
      json['rfid_list'].forEach((v) {
        rfidList?.add(RfidItem.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    if (rfidList != null) {
      data['rfid_list'] = rfidList?.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RfidItem {
  int? tagId;
  String? tagName;
  RxBool isNameEditable = false.obs;
  FocusNode focusNode = FocusNode();
  TextEditingController editingController = TextEditingController();
  String? tagIssuedDate;
  RxBool tagStatus = false.obs;

  RfidItem({
    this.tagId,
    this.tagName,
    this.tagIssuedDate,
  });

  RfidItem.fromJson(Map<String, dynamic> json) {
    tagId = json['tag_id'];
    tagName = json['tag_name'];
    tagIssuedDate = json['tag_issued_date'];
    tagStatus.value = json['tag_status'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['tag_id'] = tagId;
    data['tag_name'] = tagName;
    data['tag_issued_date'] = tagIssuedDate;
    data['tag_status'] = tagStatus.value;
    return data;
  }
}