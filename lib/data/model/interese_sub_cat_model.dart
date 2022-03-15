// To parse this JSON data, do
//
//     final intereseSubCatModel = intereseSubCatModelFromJson(jsonString);

import 'dart:convert';

IntereseSubCatModel intereseSubCatModelFromJson(String str) => IntereseSubCatModel.fromJson(json.decode(str));

String intereseSubCatModelToJson(IntereseSubCatModel data) => json.encode(data.toJson());

class IntereseSubCatModel {
  IntereseSubCatModel({
    required this.userId,
    required this.interestSubCategoryId,
  });

  String userId;
  List<String> interestSubCategoryId;

  factory IntereseSubCatModel.fromJson(Map<String, dynamic> json) => IntereseSubCatModel(
    userId: json["userId"],
    interestSubCategoryId: List<String>.from(json["interestSubCategoryId"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "userId": userId,
    "interestSubCategoryId": List<dynamic>.from(interestSubCategoryId.map((x) => x)),
  };
}
