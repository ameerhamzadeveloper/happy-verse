// To parse this JSON data, do
//
//     final intrestSelectModel = intrestSelectModelFromJson(jsonString);

import 'dart:convert';

IntrestSelectModel intrestSelectModelFromJson(String str) => IntrestSelectModel.fromJson(json.decode(str));

String intrestSelectModelToJson(IntrestSelectModel data) => json.encode(data.toJson());

class IntrestSelectModel {
  IntrestSelectModel({
    required this.userInterests,
  });

  List<UserInterest> userInterests;

  factory IntrestSelectModel.fromJson(Map<String, dynamic> json) => IntrestSelectModel(
    userInterests: List<UserInterest>.from(json["userInterests"].map((x) => UserInterest.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userInterests": List<dynamic>.from(userInterests.map((x) => x.toJson())),
  };
}

class UserInterest {
  UserInterest({
    required this.userId,
    required this.interestCategoryId,
    required this.userSubInterestDto,
  });

  String userId;
  int interestCategoryId;
  List<UserSubInterestDto> userSubInterestDto;

  factory UserInterest.fromJson(Map<String, dynamic> json) => UserInterest(
    userId: json["userId"],
    interestCategoryId: json["interestCategoryId"],
    userSubInterestDto: List<UserSubInterestDto>.from(json["userSubInterestDto"].map((x) => UserSubInterestDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "interestCategoryId": interestCategoryId,
    "userSubInterestDto": List<dynamic>.from(userSubInterestDto.map((x) => x.toJson())),
  };
}

class UserSubInterestDto {
  UserSubInterestDto({
    required this.userProfileId,
    required this.userinterestId,
    required this.interestSubCategoryId,
    required this.id,
  });

  int userProfileId;
  int userinterestId;
  int interestSubCategoryId;
  int id;

  factory UserSubInterestDto.fromJson(Map<String, dynamic> json) => UserSubInterestDto(
    userProfileId: json["userProfileId"],
    userinterestId: json["userinterestId"],
    interestSubCategoryId: json["interestSubCategoryId"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "userProfileId": userProfileId,
    "userinterestId": userinterestId,
    "interestSubCategoryId": interestSubCategoryId,
    "id": id,
  };
}
