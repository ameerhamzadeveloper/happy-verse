// To parse this JSON data, do
//
//     final postContentModel = postContentModelFromJson(jsonString);

import 'dart:convert';

PostContentModel postContentModelFromJson(String str) => PostContentModel.fromJson(json.decode(str));

String postContentModelToJson(PostContentModel data) => json.encode(data.toJson());

class PostContentModel {
  PostContentModel({
    required this.postContentDto,
  });

  List<PostContentDto> postContentDto;

  factory PostContentModel.fromJson(Map<String, dynamic> json) => PostContentModel(
    postContentDto: List<PostContentDto>.from(json["postContentDto"].map((x) => PostContentDto.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "postContentDto": List<dynamic>.from(postContentDto.map((x) => x.toJson())),
  };
}

class PostContentDto {
  PostContentDto({
    required this.fileContent,
    required this.filename,
    required this.id,
  });

  String fileContent;
  String filename;
  int id;

  factory PostContentDto.fromJson(Map<String, dynamic> json) => PostContentDto(
    fileContent: json["file_content"],
    filename: json["filename"],
    id: json["id"],
  );

  Map<String, dynamic> toJson() => {
    "file_content": fileContent,
    "filename": filename,
    "id": id,
  };
}
