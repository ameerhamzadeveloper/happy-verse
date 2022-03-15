import 'package:story_view/story_view.dart';

class StoryModel{
  List<StoryItem> storyItem;
  StoryController controller;
  String title;
  String date;
  String profileImage;
  StoryModel({required this.controller,required this.storyItem,required this.profileImage,required this.title,required this.date});
}