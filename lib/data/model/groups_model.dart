// To parse this JSON data, do
//
//     final groupsModel = groupsModelFromJson(jsonString);

import 'dart:convert';

GroupsModel groupsModelFromJson(String str) => GroupsModel.fromJson(json.decode(str));

String groupsModelToJson(GroupsModel data) => json.encode(data.toJson());

class GroupsModel {
  GroupsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<Groups> data;

  factory GroupsModel.fromJson(Map<String, dynamic> json) => GroupsModel(
    status: json["status"],
    message: json["message"],
    data: List<Groups>.from(json["data"].map((x) => Groups.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class Groups {
  Groups({
    required this.memberRole,
    required this.groupId,
    required this.groupAdminId,
    required this.groupName,
    required this.groupImageUrl,
    required this.groupDescription,
    required this.groupPrivacy,
    required this.addDate,
    required this.editDate,
  });

  String memberRole;
  String groupId;
  String groupAdminId;
  String groupName;
  String groupImageUrl;
  dynamic groupDescription;
  String groupPrivacy;
  DateTime addDate;
  dynamic editDate;

  factory Groups.fromJson(Map<String, dynamic> json) => Groups(
    memberRole: json["memberRole"],
    groupId: json["groupId"],
    groupAdminId: json["groupAdminId"],
    groupName: json["groupName"],
    groupImageUrl: json["groupImageUrl"],
    groupDescription: json["groupDescription"],
    groupPrivacy: json["groupPrivacy"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
  );

  Map<String, dynamic> toJson() => {
    "memberRole": memberRole,
    "groupId": groupId,
    "groupAdminId": groupAdminId,
    "groupName": groupName,
    "groupImageUrl": groupImageUrl,
    "groupDescription": groupDescription,
    "groupPrivacy": groupPrivacy,
    "addDate": addDate.toIso8601String(),
    "editDate": editDate,
  };
}
