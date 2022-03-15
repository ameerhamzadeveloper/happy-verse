import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:video_player/video_player.dart';
import '../../data/repository/post_repository.dart';
part 'story_state.dart';

class StoryCubit extends Cubit<StoryState> {
  StoryCubit() : super(StoryState(
    textStyle: textStyle,
    textStyle1: textStyle1,
    isEmojiOpen: emojiShowing,
    message: message,
    pageColor: pageColors,
  ));

  final repository = PostRepository();

  static TextStyle textStyle = fonts[0];
  static TextStyle textStyle1 = fonts1[0];
  static bool emojiShowing = true;
  static TextEditingController message = TextEditingController();
  onBackspacePressed() {
    message
      ..text = message.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }


  onEmojiSelected(Emoji emoji) {
    message
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }
  openEmoji(){
    emojiShowing = !emojiShowing;
    emit(state.copyWith(isEmojiOpenn: emojiShowing));
  }

  static List<TextStyle> fonts = [
    GoogleFonts.montserrat(fontSize: 30,color: Colors.white.withOpacity(0.4)),
    GoogleFonts.quintessential(fontSize: 30,color: Colors.white.withOpacity(0.4)),
    GoogleFonts.playfairDisplay(fontSize: 30,color: Colors.white.withOpacity(0.4)),
    GoogleFonts.nunitoSans(fontSize: 30,color: Colors.white.withOpacity(0.4)),
    GoogleFonts.zenKakuGothicAntique(fontSize: 30,color: Colors.white.withOpacity(0.4)),
    GoogleFonts.josefinSans(fontSize: 30,color: Colors.white.withOpacity(0.4)),
  ];
  static List<TextStyle> fonts1 = [
    GoogleFonts.montserrat(fontSize: 30,color: Colors.white),
    GoogleFonts.quintessential(fontSize: 30,color: Colors.white),
    GoogleFonts.playfairDisplay(fontSize: 30,color: Colors.white),
    GoogleFonts.nunitoSans(fontSize: 30,color: Colors.white),
    GoogleFonts.zenKakuGothicAntique(fontSize: 30,color: Colors.white),
    GoogleFonts.josefinSans(fontSize: 30,color: Colors.white),
  ];
  int fontIndex = 0;
  getFonst(){
    var ran= Random().nextInt(fonts.length);
    fontIndex = ran;
      textStyle = fonts[ran];
      textStyle1 = fonts1[ran];
      emit(state.copyWith(textStylee: textStyle,textStyle11: textStyle1));
  }
  static List<Color> pageColors = [
    Colors.redAccent,
    Colors.green,
    Colors.brown,
    Colors.purpleAccent,
    Colors.deepPurpleAccent
  ];
  VideoPlayerController? controller;

  String getCurrentFont(){
    switch(fontIndex){
      case 0:
        return "montserrat";
      case 1:
        return "quintessential";
      case 2:
        return "playfairDisplay";
      case 3:
        return "nunitoSans";
      case 4:
        return "zenKakuGothicAntique";
      case 5:
        return "josefinSans";
      default:
        return "montserrat";
    }
  }

  int currentColor = 0;

  assignColor(int v){
    currentColor = v;
  }

  XFile? baseImage;
  XFile? baseVideo;

  getImage(BuildContext context)async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    baseImage = image;
    emit(state.copyWith(storyImagee: image));
  }
  getVideo(BuildContext context)async{
    XFile? video = await ImagePicker().pickVideo(source: ImageSource.gallery);
    baseVideo = video;
    controller = VideoPlayerController.file(File(video!.path))..initialize();
    emit(state.copyWith(storyVideoe: video,videoControllerr: controller));
  }

  DateTime date = DateTime.now();
  final dF = DateFormat('dd MMM yyyy');
  final tF = DateFormat('hh:mm a');

  int daysBetween(DateTime from, DateTime to) {
    from = DateTime(from.year, from.month, from.day);
    to = DateTime(to.year, to.month, to.day);
    return (to.difference(from).inHours / 24).round();
  }

  getTimeDiff(){
    // February 22, 2022 at 7:39:42 PM UTC+5

    print(Jiffy("2022-02-19 3:00 PM", "yyyy-MM-dd hh:mm a").fromNow());
    print(Jiffy("February 22, 2022 at 7:39:42 PM UTC+5", "MM dd, yyyy at hh:mm a").fromNow());

  }

  String getPostType(){
    if(state.storyImage == null && state.storyVideo == null){
      return "text";
    }else if(state.storyImage == null && state.message.text.isEmpty){
      return "video";
    }else{
      return "image";
    }
  }


  createPost(){
    // Map<String ,Object> map = {
    //   'userId':"733439cc-a4e5-4efe-bbff-266499ab0104",
    //   "privacy": "",
    //   "content_type": "story",
    //   "postType": getPostType(),
    //   "font_color": "",
    //   "text_back_ground": bgImage,
    //   "posted_date": "${dF.format(date)} ${tF.format(date)}",
    //   "expire_at": "",
    //   "interest": "",
    //   "location":"",
    //   "active": true,
    // };
    // if(baseImage != null){
    //   map['postContentDto'] = [
    //     {
    //       "file_content": baseImage!,
    //       "filename": "MYFILE",
    //       "id": 0,
    //     }
    //   ];
    // }else if(videoThumb != null){
    //   map['postContentDto'] = [
    //     {
    //       "file_content": baseVideo!,
    //       "filename": "MYFILE",
    //       "id": 0,
    //     }
    //   ];
    // }
    String bear = "bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1c2VySWQiOiI3MzM0MzljYy1hNGU1LTRlZmUtYmJmZi0yNjY0OTlhYjAxMDQiLCJmdWxsTmFtZSI6IlN1cGVyICBBZG1pbiIsInVuaXF1ZV9uYW1lIjoiYWRtaW5AYWRtaW4uY29tIiwiZW1haWxJZCI6ImFkbWluQGFkbWluLmNvbSIsInJvbGUiOiJBZG1pbiIsInBlcm1pc3Npb25zIjoiVXNlclVwZGF0ZSxVc2VyQ3JlYXRlLFVzZXJEZWxldGUsVXNlclNpbmdsZVZpZXcsVXNlckxpc3RWaWV3IiwiaXNzIjoiaHR0cDovL2xvY2FsaG9zdDo1OTgyMiIsImF1ZCI6IjQxNGUxOTI3YTM4ODRmNjhhYmM3OWY3MjgzODM3ZmQxIiwiZXhwIjoxNjQ1MzU2MTEwLCJuYmYiOjE2NDUyNjk3MTB9.1aZCbY4kDHMh0IPmVr112f6h8pPbp0S_yJ0T9D128ZA";
    print("${dF.format(date)} at ${tF.format(date)}");
    // repository.createPost(map, bear).then((response){
    //   print(response.body);
    //   print(response.statusCode);
    //   if(response.statusCode == 200){
    //
    //   }
    // });
  }

  postStory(String userId,String accessToken){

    emit(state.copyWith(isUploadedd: false));
    Map<String ,dynamic> map = {
      'userId': userId,
      "privacy": '',
      "content_type": "story",
      "postType": getPostType(),
      "font_color": fontIndex.toString(),
      "text_back_ground": currentColor.toString(),
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": "",
      "active": '1',
      'postContentText': "",
      "caption": state.message.text,
    };
    print("${dF.format(date)} at ${tF.format(date)}");
    if(baseImage != null){
      repository.createStoryPost(map,accessToken,userId,content:File(baseImage!.path)).then((response){
        print(response.body);
        emit(state.copyWith(isUploadedd: false));
      });
    }else if(baseVideo != null){
      repository.createStoryPost(map,accessToken,userId,content:File(baseVideo!.path)).then((response){
        print(response.body);
        emit(state.copyWith(isUploadedd: false));
      });
    }else{
      repository.createStoryPost(map,accessToken,userId).then((response){
        print(response.body);
        emit(state.copyWith(isUploadedd: false));
      });
    }
  }

}
