class FeedsCard{

  String profileNmae;
  String profileImage;
  String date;
  String postType;
  String content;
  String caption;
  String like;
  String comment;
  String userId;
  String docId;
  String textBg;
  String videoThumb;

  FeedsCard({required this.userId,required this.comment,
  required this.like,required this.date,required this.caption,
  required this.content,required this.postType,required this.profileImage,
  required this.profileNmae,required this.docId,required this.textBg,required this.videoThumb});

}