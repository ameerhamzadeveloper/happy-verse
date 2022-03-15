class GroupPostModel{

  String profileName;
  String profielImage;
  String postImage;
  int like;
  int commentsCount;
  DateTime date;

  GroupPostModel({required this.profileName,
    required this.date,required this.commentsCount,
    required this.like,required this.postImage,required this.profielImage});
}