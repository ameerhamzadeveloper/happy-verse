// To parse this JSON data, do
//
//     final feedsPostsModel = feedsPostsModelFromJson(jsonString);

import 'dart:convert';

FeedsPostsModel feedsPostsModelFromJson(String str) => FeedsPostsModel.fromJson(json.decode(str));

String feedsPostsModelToJson(FeedsPostsModel data) => json.encode(data.toJson());

class FeedsPostsModel {
  FeedsPostsModel({
    required this.status,
    required this.message,
    required this.data,
  });

  int status;
  String message;
  List<FeedsPosts> data;

  factory FeedsPostsModel.fromJson(Map<String, dynamic> json) => FeedsPostsModel(
    status: json["status"],
    message: json["message"],
    data: List<FeedsPosts>.from(json["data"].map((x) => FeedsPosts.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "status": status,
    "message": message,
    "data": List<dynamic>.from(data.map((x) => x.toJson())),
  };
}

class FeedsPosts {
  FeedsPosts({
    this.postId,
    this.userId,
    this.userName,
    this.profileImageUrl,
    this.caption,
    this.privacy,
    this.contentType,
    this.postType,
    this.fontColor,
    this.textBackGround,
    this.postedDate,
    this.expireAt,
    this.interest,
    this.active,
    this.profileName,
    this.location,
    this.postContentText,
    this.totalLike,
    this.totalComment,
    this.isLiked,
    this.postFiles,
    required this.isMyPost
  });

  String? postId;
  String? userId;
  String? userName;
  String? profileImageUrl;
  String? caption;
  String? privacy;
  String? contentType;
  String? postType;
  String? fontColor;
  String? textBackGround;
  DateTime? postedDate;
  String? expireAt;
  String? interest;
  String? active;
  String? profileName;
  String? location;
  String? postContentText;
  String? totalLike;
  String? totalComment;
  bool? isLiked;
  bool isMyPost;
  List<PostFile>? postFiles;

  factory FeedsPosts.fromJson(Map<String, dynamic> json) => FeedsPosts(
    postId: json["postId"],
    userId: json["userId"],
    userName: json["userName"],
    profileImageUrl: json["profileImageUrl"],
    caption: json["caption"],
    privacy: json["privacy"],
    contentType: json["content_type"],
    postType: json["postType"],
    fontColor: json["font_color"],
    textBackGround: json["text_back_ground"],
    postedDate: DateTime.parse(json["posted_date"]),
    expireAt: json["expire_at"],
    interest: json["interest"],
    active: json["active"],
    profileName: json["profileName"],
    location: json["location"],
    postContentText: json["postContentText"],
    totalLike: json["totalLike"],
    totalComment: json["totalComment"],
    isLiked: json["isLiked"],
    isMyPost: false,
    postFiles: List<PostFile>.from(json["postFiles"].map((x) => PostFile.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postId": postId,
    "userId": userId,
    "userName": userName,
    "profileImageUrl": profileImageUrl,
    "caption": caption,
    "privacy": privacy,
    "content_type": contentType,
    "postType": postType,
    "font_color": fontColor,
    "text_back_ground": textBackGround,
    "posted_date": postedDate!.toIso8601String(),
    "expire_at": expireAt,
    "interest": interest,
    "active": active,
    "profileName": profileName,
    "location": location,
    "postContentText": postContentText,
    "totalLike": totalLike,
    "totalComment": totalComment,
    "isLiked": isLiked,
    "postFiles": List<dynamic>.from(postFiles!.map((x) => x.toJson())),
  };
}

class PostFile {
  PostFile({
    required this.postFileId,
    required this.postId,
    required this.userId,
    required this.postFileUrl,
  });

  String postFileId;
  String postId;
  String userId;
  String postFileUrl;

  factory PostFile.fromJson(Map<String, dynamic> json) => PostFile(
    postFileId: json["postFileId"],
    postId: json["postId"],
    userId: json["userId"],
    postFileUrl: json["postFileUrl"],
  );

  Map<String, dynamic> toJson() => {
    "postFileId": postFileId,
    "postId": postId,
    "userId": userId,
    "postFileUrl": postFileUrl,
  };
}
