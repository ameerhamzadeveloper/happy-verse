// To parse this JSON data, do
//
//     final searchUserModel = searchUserModelFromJson(jsonString);

import 'dart:convert';

SearchUserModel searchUserModelFromJson(String str) => SearchUserModel.fromJson(json.decode(str));

String searchUserModelToJson(SearchUserModel data) => json.encode(data.toJson());

class SearchUserModel {
  SearchUserModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<SearchedUsers> data;

  factory SearchUserModel.fromJson(Map<String, dynamic> json) => SearchUserModel(
    status: json["status"],
    message: json["message"],
    data: List<SearchedUsers>.from(json["data"].map((x) => SearchedUsers.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class SearchedUsers {
  SearchedUsers({
    this.userId,
    this.userName,
    this.email,
    this.dob,
    this.martialStatus,
    this.profileImageUrl,
    this.gender,
    this.city,
    this.postCode,
    this.phoneNo,
    this.country,
    this.lat,
    this.long,
    this.address,
    this.following,
    this.follower,
    this.totalPosts,
    this.userTypeId,
    this.isActive,
    this.addDate,
    this.editDate,
    this.isFriend,
  });

  String? userId;
  String? userName;
  String? email;
  DateTime? dob;
  String? martialStatus;
  String? profileImageUrl;
  String? gender;
  City? city;
  String? postCode;
  PhoneNo? phoneNo;
  String? country;
  String? lat;
  String? long;
  Address? address;
  String? following;
  String? follower;
  String? totalPosts;
  String? userTypeId;
  String? isActive;
  DateTime? addDate;
  dynamic? editDate;
  IsFriend? isFriend;

  factory SearchedUsers.fromJson(Map<String, dynamic> json) => SearchedUsers(
    userId: json["userId"],
    userName: json["userName"],
    email: json["email"],
    dob: DateTime.parse(json["DOB"]),
    martialStatus: json["martialStatus"],
    profileImageUrl: json["profileImageUrl"],
    gender: json["gender"],
    city: cityValues.map?[json["city"]],
    postCode: json["postCode"],
    phoneNo: phoneNoValues.map?[json["phoneNo"]],
    country: json["country"],
    lat: json["lat"],
    long: json["long"],
    address: addressValues.map?[json["address"]],
    following: json["following"],
    follower: json["follower"],
    totalPosts: json["totalPosts"],
    userTypeId: json["userTypeId"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    isFriend: isFriendValues.map![json["IsFriend"]],
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "userName": userName,
    "email": email,
    "DOB": "${dob!.year.toString().padLeft(4, '0')}-${dob!.month.toString().padLeft(2, '0')}-${dob!.day.toString().padLeft(2, '0')}",
    "martialStatus": martialStatus,
    "profileImageUrl": profileImageUrl,
    "gender": gender,
    "city": cityValues.reverse[city],
    "postCode": postCode,
    "phoneNo": phoneNoValues.reverse[phoneNo],
    "country": country,
    "lat": lat,
    "long": long,
    "address": addressValues.reverse[address],
    "following": following,
    "follower": follower,
    "totalPosts": totalPosts,
    "userTypeId": userTypeId,
    "isActive": isActive,
    "addDate": addDate!.toIso8601String(),
    "editDate": editDate,
    "IsFriend": isFriendValues.reverse[isFriend],
  };
}

enum Address { SAHIWAL, EMPTY }

final addressValues = EnumValues({
  " ": Address.EMPTY,
  "Sahiwal": Address.SAHIWAL
});

enum City { SAHIWAL, EMPTY, CITY_SAHIWAL }

final cityValues = EnumValues({
  "Sahiwal": City.CITY_SAHIWAL,
  "": City.EMPTY,
  "sahiwal": City.SAHIWAL
});

enum IsFriend { FOLLOW }

final isFriendValues = EnumValues({
  "Follow": IsFriend.FOLLOW
});

enum PhoneNo { EMPTY, THE_03166093244 }

final phoneNoValues = EnumValues({
  " ": PhoneNo.EMPTY,
  "03166093244": PhoneNo.THE_03166093244
});

class EnumValues<T> {
  Map<String, T>? map;
  Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map!.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap!;
  }
}
