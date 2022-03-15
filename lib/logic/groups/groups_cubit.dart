import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hapiverse/data/model/groups_model.dart';
import 'package:hapiverse/data/repository/group_repository.dart';
import 'package:hapiverse/logic/public_logics.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/feeds/story/design_story.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';

part 'groups_state.dart';

class GroupsCubit extends Cubit<GroupsState> {
  GroupsCubit() : super(
      GroupsState(
          privacyDownValue: privacyDownList,
          privacyValue: privacyValue,
        error: "",
        isSub: false,
        isGroupLoading: true,
        searchGroups:  []
      ));

  final publicLogics = PublicLogics();
  final repository = GroupRepository();

  static List<String> privacyDownList = [
    "Private",
    "Public"
  ];
  static String privacyValue = "Private";

  changePrivacyValue(String val){
    emit(state.copyWith(privacyValuee: val));
  }

  assignName(String name){
    emit(state.copyWith(groupNamee: name));
  }
  XFile? cover;

  getImage()async{
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(groupCoverr: File(image!.path)));
    cover = image;
    cropImage();
  }

  assignErro(String erro){
    emit(state.copyWith(errorr: erro));
  }
  assignisSub(){
    emit(state.copyWith(isSubb: true));
  }

  Future<Null> cropImage()async{
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: cover!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop Cover',
            toolbarColor: kUniversalColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: kSecendoryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(

        )
    );
    emit(state.copyWith(groupCoverr: File(croppedFile!.path)));
  }

  createGroup(String userID,BuildContext context,String accessToken)async{
    Map<String,dynamic> map = {
      'groupName': state.groupName,
      'groupPrivacy':state.privacyValue,
      'userId': userID,
    };
    repository.createGroup(map,accessToken,userID,File(state.groupCover!.path)).then((response){
      print(response.body);
      var de = json.decode(response.body);
      if(de['message'] == "Data successfuly save"){
        emit(state.copyWith(groupCoverr: null,isSubb: false,groupNamee: ""));
        Fluttertoast.showToast(msg: "Group created successfully");
        getGroups(userID, accessToken);
        Navigator.pop(context);
      }
    });
  }
  List<Groups> groups = [];
  getGroups(String userId,String accessToken){
    emit(state.copyWith(isGroupLoadingg: true));
    repository.getGroups(accessToken, userId).then((response) {
      final result = groupsModelFromJson(response.body);
      groups = result.data;
      print(response.body);
      emit(state.copyWith(groupss: result.data,isGroupLoadingg: false));
    });
  }

  List<Groups> searchGroupList = [];

  searchGroup(String value){
    groups.forEach((g) {
      if(g.groupName.toLowerCase().contains(value.toLowerCase())){
        print("Searched");
        searchGroupList.add(g);
        emit(state.copyWith(searchGroupss: searchGroupList));
        print(searchGroupList.length);
        print(state.searchGroups!.length);
      }else{
        searchGroupList.clear();
        emit(state.copyWith(searchGroupss: searchGroupList));
        print(state.searchGroups!.length);
      }
    });
  }

  assignCaption(String cap){
    emit(state.copyWith(captionn: cap));
  }

  String? groupId;
  assignGroupId(String val){
    groupId = val;
  }
  addGroupPosts(String userID,BuildContext context){
    FirebaseFirestore.instance.collection('users').doc(userID).get().then((value){
      var data = value.data();
      var map = {
        'title': state.caption,
        'image':cover,
        'email': data?['email'],
        'profileImage': data?['profile_url'],
        'profileName':data?['name'],
      };
      repository.addGropPost(map,groupId!);
      Future.delayed(Duration(seconds: 3),(){
        Navigator.pop(context);
      });
    });
    emit(state.copyWith(captionn: '',groupCoverr: null,groupNamee: '',isSubb: false));
  }
}
