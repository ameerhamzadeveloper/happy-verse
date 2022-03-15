import 'dart:convert';
import 'dart:ffi';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hapiverse/data/model/post_content_model.dart';
import 'package:hapiverse/data/repository/group_repository.dart';
import 'package:hapiverse/data/repository/post_repository.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/feeds/post/video_edit_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:multi_image_picker2/multi_image_picker2.dart';
import 'package:video_player/video_player.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../data/model/post_places_model.dart';
import '../../utils/config/assets_config.dart';

part 'post_state.dart';

class PostCubit extends Cubit<PostState> {
  PostCubit() : super(
      PostState(
        dropList: dropList,
        dropVal: value,
        bottomSheetWidgets: listView,
        initChildSize: initialChildSize,
        images: [],
        postBGImage: bgImage,
        postController: postEditingController,
        captionTextStyle: captionTextStyle,
        textController: textEditingController
      ),
  );

  final repository = PostRepository();
  final groupRepository = GroupRepository();

  String postBg = '';

  static double initialChildSize = 0.5;
  static String bgImage = "";
  static TextStyle captionTextStyle = const TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500);
  static TextEditingController postEditingController = TextEditingController();
  static TextEditingController textEditingController = TextEditingController();
  Uint8List? videoThumb;
  changeBottomSheetSize() {
    initialChildSize = 0.1;
    emit(state.copyWith(initChildSizee: initialChildSize));
  }
  setPostBg(String val){
    postBg = val;
  }

  changeBGImage(int ind) {
    bgImage = "${AssetConfig.postBgBase}bg$ind.png";
    images = [];
    baseImage = null;
    videoThumb = null;
    if(ind == 1 || ind == 2 || ind == 4 || ind == 5){
      captionTextStyle = TextStyle(fontSize: 18,color: Colors.white,fontWeight: FontWeight.w500);
    }else{
      captionTextStyle = TextStyle(fontSize: 18,color: Colors.black,fontWeight: FontWeight.w500);
    }
    emit(state.copyWith(postBGImagee: bgImage,captionTextStylee: captionTextStyle));
  }

  static List<Widget> listView = [
    IconButton(
        onPressed: () {}, icon: const Icon(Icons.keyboard_arrow_up_outlined)),
    const ListTile(
      leading: Icon(Icons.image),
      title: Text("Image"),
    ),
    const ListTile(
      leading: Icon(Icons.video_call_rounded, color: Colors.blue,),
      title: Text("Vidoe"),
    ),
    const ListTile(
      leading: Icon(Icons.location_on, color: Colors.red,),
      title: Text("Location"),
    ),
    const ListTile(
      leading: Icon(Icons.camera_alt, color: Colors.red,),
      title: Text("Record"),
    )
  ];

  static List<String> images = [];
  Uint8List? baseImage;

  Future<void> pickImages() async {
    // List<String> images = [];
    XFile? result = await ImagePicker().pickImage(source: ImageSource.gallery);
    images.add(result!.path);
    baseImage = await result.readAsBytes();
    // List<Asset> resultList = <Asset>[];
    // String error = 'No Error Detected';
    //
    // try {
    //   resultList = await MultiImagePicker.pickImages(
    //     maxImages: 5,
    //     enableCamera: true,
    //     selectedAssets: images,
    //     cupertinoOptions: const CupertinoOptions(
    //       takePhotoIcon: "chat",
    //       doneButtonTitle: "Done",
    //     ),
    //     materialOptions: const MaterialOptions(
    //       actionBarColor: "#abcdef",
    //       actionBarTitle: "Add Images",
    //       allViewTitle: "All Photos",
    //       useDetailsView: false,
    //       selectCircleStrokeColor: "#000000",
    //     ),
    //   );
    // } on Exception catch (e) {
    //   error = e.toString();
    // }
    // images = resultList;
    // videoThumb = null;
    print(images[0]);
    emit(state.copyWith(imagese: images,textControllerr: TextEditingController()));
    emit(state.copyWith(showImagess: images,showTextt: ""));
  }

  static String value = '🌎 Public';
  static List<String> dropList = [
    "🌎 Public",
    "🔒 Private"
  ];

  changeDropVal(String val) {
    emit(state.copyWith(dropVall: val));
  }

  XFile? baseVideo;

  pickVideo(BuildContext context)async{
    XFile? videoFile = await ImagePicker().pickVideo(source: ImageSource.gallery);
    print(videoFile);
    baseVideo = videoFile!;
    getVideoThumbnail(videoFile.path);
    nextScreen(context, VideoEditPage(path: videoFile.path));

  }
  VideoPlayerController? controller;
  getVideoThumbnail(String path)async{
    videoThumb = await VideoThumbnail.thumbnailData(
      video: path,
      imageFormat: ImageFormat.JPEG,
      // maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    print(videoThumb);
    images = [];
    baseImage = null;
    emit(state.copyWith(videoFil: videoThumb,showVideoFilee:videoThumb,textControllerr: TextEditingController(),videoFilePathh: baseVideo!.path,));
    initVideo();
  }

  PlaceNearby? places;
  getNeabyLocations()async{
    Position pos = await Geolocator.getCurrentPosition();
    repository.getNearbyPlaces(pos.latitude, pos.longitude).then((response){
      var data = placeNearbyFromJson(response.body);
      places = data;
      emit(state.copyWith(placess: places));
    });
  }

  initVideo(){
    controller = VideoPlayerController.file(File(baseVideo!.path))..initialize().then((value) {
      emit(state.copyWith(videoControllerr: controller));
      state.videoController!.position.asStream().listen((event) {
        //   progress = event!;
        //
        state.videoController!.addListener(() {

          // progress = controller.value.position;
          emit(state.copyWith(isVideoLoadingg: false,
              videoTotalDurationn: controller!.value.duration,
              videoProgresss: state.videoController!.value.position,videoControllerr: controller));

          print("Pause");
        });
      });
    });
  }

  disposeVideoController(){
    controller = null;
    state.copyWith(videoControllerr: controller);
  }

  assignPlaces(val){
    emit(state.copyWith(currentPlacee: val));
  }

  DateTime date = DateTime.now();
  final dF = DateFormat('dd MMM yyyy');
  final tF = DateFormat('hh:mm a');
  final authBloc = RegisterCubit();

  String getPostType(){
    if(images.isEmpty && videoThumb == null){
      return "text";
    }else if(images.isEmpty && state.textController.text.isEmpty){
      return "video";
    }else{
      return "image";
    }
  }

  createPost(String userID,String token){
    emit(state.copyWith(isUplaodeed: false));
    Map<String ,dynamic> map = {
        'userId': userID,
        "privacy": state.dropVal,
        "content_type": "feeds",
        "postType": getPostType(),
        "font_color": "",
        "text_back_ground": bgImage,
        "posted_date": "${dF.format(date)} at ${tF.format(date)}",
        "expire_at": "",
        "interest": "",
        "location": state.currentPlace ?? "",
        "active": '1',
        'postContentText': state.postController.text,
        "caption": state.postController.text,
    };
    print("${dF.format(date)} at ${tF.format(date)}");
    if(getPostType() == 'text'){
      repository.createPost(map,token,userID).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null,postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,isUplaodeed: true,));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }else if(getPostType() == 'image'){
      repository.createPost(map, token,userID, image: state.images!).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null, postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,isUplaodeed: true));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }else{
      repository.createPost(map, token,userID,videoFile:  File(state.videoFilePath!)).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null,postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,videoControllerr: null,videoFilePathh: null,isUplaodeed: true));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }
  }

  assingVideoPath(String path){
    emit(state.copyWith(videoFilePathh: path));
  }

  createGroupPost(String userID,String token,String groupId){
    emit(state.copyWith(isUplaodeed: false));
    Map<String ,dynamic> map = {
      'userId': userID,
      "privacy": state.dropVal,
      "content_type": "group",
      "postType": getPostType(),
      "font_color": "",
      "text_back_ground": bgImage,
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": state.currentPlace ?? "",
      "active": '1',
      'postContentText': state.postController.text,
      "caption": state.postController.text,
      'groupId':groupId,
    };
    print("${dF.format(date)} at ${tF.format(date)}");
    if(getPostType() == 'text'){
      repository.createPost(map,token,userID).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null,postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,isUplaodeed: true,));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }else if(getPostType() == 'image'){
      repository.createPost(map, token,userID, image: state.images!).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null, postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,isUplaodeed: true));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }else{
      repository.createPost(map, token,userID,videoFile:  File(baseVideo!.path)).then((response){
        print(response.body);
        print(response.statusCode);
        if(response.statusCode == 200){
          Fluttertoast.showToast(msg: "Post Uploaded");
          emit(state.copyWith(imagese: [],videoFil: null,postControllerr: TextEditingController(text: ""),postBGImagee: bgImage,videoControllerr: null,videoFilePathh: null,isUplaodeed: true));
        }else{
          Fluttertoast.showToast(msg: "Something went wrong!");
        }
      });
    }
  }
  ontextControllerChange(String value){
    emit(state.copyWith(showTextt: value));
  }

  String? groupId;

  assignGroupId(String val){
    groupId = val;
  }

  clearImage(int index){
    images.removeAt(index);
    emit(state.copyWith(imagese: images));
  }

  addGroupPost(){
    Map<String ,Object> map = {
      // "userId": authBloc.userID!,
      "privacy": state.dropVal,
      "content_type": "feeds",
      "postType": getPostType(),
      "font_color": "",
      "text_back_ground": bgImage,
      "posted_date": "${dF.format(date)} at ${tF.format(date)}",
      "expire_at": "",
      "interest": "",
      "location": state.currentPlace ?? "",
      "active": true,
    };
    if(baseImage != null){
      map['postContentDto'] = [
        {
          "file_content": baseImage!,
          "filename": "MYFILE",
          "id": 0,
        }
      ];
    }else if(videoThumb != null){
      map['postContentDto'] = [
        {
          "file_content": baseVideo!,
          "filename": "MYFILE",
          "id": 0,
        }
      ];
    }
    // groupRepository.addGropPost(map, groupId!);
  }


}
