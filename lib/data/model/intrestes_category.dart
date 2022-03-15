// To parse this JSON data, do
//
//     final intrestModel = intrestModelFromJson(jsonString);

import 'dart:convert';

IntrestModel intrestModelFromJson(String str) => IntrestModel.fromJson(json.decode(str));

String intrestModelToJson(IntrestModel data) => json.encode(data.toJson());

class IntrestModel {
  IntrestModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<IntrestCategory> data;

  factory IntrestModel.fromJson(Map<String, dynamic> json) => IntrestModel(
    status: json["status"],
    message: json["message"],
    data: List<IntrestCategory>.from(json["data"].map((x) => IntrestCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class IntrestCategory {
  IntrestCategory({
    required this.intrestCategoryId,
    required this.intrestCategoryTitle,
    required this.interestImage,
    required this.isActive,
    required this.isSelect,
    required this.intrestSubCategory,
  });

  String intrestCategoryId;
  String intrestCategoryTitle;
  String interestImage;
  String isActive;
  bool isSelect = false;
  List<IntrestSubCategory> intrestSubCategory;

  factory IntrestCategory.fromJson(Map<String, dynamic> json) => IntrestCategory(
    intrestCategoryId: json["intrestCategoryId"],
    intrestCategoryTitle: json["intrestCategoryTitle"],
    interestImage: json["interestImage"],
    isActive: json["isActive"],
    isSelect: false,
    intrestSubCategory: List<IntrestSubCategory>.from(json["intrestSubCategory"].map((x) => IntrestSubCategory.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "intrestCategoryId": intrestCategoryId,
    "intrestCategoryTitle": intrestCategoryTitle,
    "interestImage": interestImage,
    "isActive": isActive,
    "intrestSubCategory": List<dynamic>.from(intrestSubCategory.map((x) => x.toJson())),
  };
}

class IntrestSubCategory {
  IntrestSubCategory({
    required this.interestSubCategoryId,
    required this.interestCategoryId,
    required this.interestSubCategoryTitle,
    required this.isActive,
    required this.addDate,
    this.editDate,
    required this.isSelect,
  });

  String interestSubCategoryId;
  String interestCategoryId;
  String interestSubCategoryTitle;
  String isActive;
  DateTime addDate;
  dynamic editDate;
  bool isSelect = false;

  factory IntrestSubCategory.fromJson(Map<String, dynamic> json) => IntrestSubCategory(
    interestSubCategoryId: json["interestSubCategoryId"],
    interestCategoryId: json["interestCategoryId"],
    interestSubCategoryTitle: json["interestSubCategoryTitle"],
    isActive: json["isActive"],
    addDate: DateTime.parse(json["addDate"]),
    editDate: json["editDate"],
    isSelect: false
  );

  Map<String, dynamic> toJson() => {
    "interestSubCategoryId": interestSubCategoryId,
    "interestCategoryId": interestCategoryId,
    "interestSubCategoryTitle": interestSubCategoryTitle,
    "isActive": isActive,
    "addDate": addDate.toIso8601String(),
    "editDate": editDate,
  };
}
