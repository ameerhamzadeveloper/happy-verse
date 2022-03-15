import 'dart:convert';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hapiverse/data/model/get_all_my_post_model.dart';
import 'package:hapiverse/data/model/search_user_model.dart';
import 'package:hapiverse/data/repository/profile_repository.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:http/http.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileState(
    relationDropList: relationStatusList,
    genderList: genderList,
    isProfileUpdating: false
  ));

  final repository = ProfileRepository();
  static List<String> relationStatusList = [
    'Single',
    'Engaged',
    'Married',
  ];

  changeRelationDrop(val) {
    emit(state.copyWith(relationShipp: val));
  }

  static List<String> genderList = [
    'Male',
    'Female',
    'other',
  ];

  changeGenderDrop(val) {
    emit(state.copyWith(genderr: val));
  }

  fetchMyPRofile(String id,String token){
    repository.getProfile(id,token).then((response){
      print(response.body);
      var deco = json.decode(response.body);
      var d = deco['data'];
      emit(state.copyWith(hobbyy: "FootBall",cityy: d['city'],
        countryy: d['country'],followerss: d['follower'],followingg: d['following'],
        genderr: d['gender'],profileImagee: d['profileImageUrl'],
        profileNamee: d['userName'],
      relationShipp: d['martialStatus'],totalPostt: "0",
        dateOfBirt: d['DOB'],
        phoneNoo: d['phoneNo']
      ),
      );
    });
  }

  getFriendList(String id,String token){
    repository.getFriendList(id,token).then((response){
      print(response.body);
    });
  }

  fetchOtherProfile(String id,String token,String myUserId){
    repository.getOtherProfile(id,token,myUserId).then((response){
      print("sdf ${response.body}");
      emit(state.copyWith(otherProfileInfoResponsee:response));
    });
  }
  List<GetMyAllPosts> allOtherPosts = [];

  addFollow(String userId,String followerId,String token){
    repository.addFollower(followerId, token, userId).then((response){
      print(response.body);
      fetchOtherProfile(userId, token, followerId);
    });
  }

  fetchOtherAllPost(String id,String token,String myUserId){
    repository.getOtherAllPorst(id,token,myUserId).then((response){
      var data = getAllMyPostsModelFromJson(response.body);
      print("other post${response.body}");
      emit(state.copyWith(allOtherPostss:data.data));
    });
  }


  fetchAllMyPosts(String token,String myUserId){
    repository.fetchMyPosts(token,myUserId).then((response){
      var data = getAllMyPostsModelFromJson(response.body);
      print(response.body);
      emit(state.copyWith(allMyPostss:data.data));
    });
  }

  XFile? profileImage;
  getImageGallery() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
  }
  getImageCamera() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
    emit(state.copyWith(profileUpdatedImagee: File(image!.path)));
  }

  Future<Null> cropImage()async{
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: state.profileUpdatedImage!.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: kUniversalColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: kSecendoryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    emit(state.copyWith(profileUpdatedImagee: croppedFile));
  }

  updateUserProfileImage(String userId,String token,BuildContext context){
    emit(state.copyWith(isProfileUpdatingg: true));
    repository.editUserProfileImage(userId, File(state.profileUpdatedImage!.path), token).then((response){
      var dec = json.decode(response.body);
      if(dec['message'] == "Data successfuly save"){
        Fluttertoast.showToast(msg: "Profile Image Updated");
        fetchMyPRofile(userId, token);
        emit(state.copyWith(isProfileUpdatingg: false));
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Something Went Wrong Try again!");
      }
    });
  }

  setProfileName(String profileName){
    emit(state.copyWith(profileNamee: profileName));
  }
  setCityVal(String cityVal){
    emit(state.copyWith(cityy: cityVal));
  }
  setCountryVal(String countryVal){
    emit(state.copyWith(countryy: countryVal));
  }
  setPhoneNum(String phoneNo){
    emit(state.copyWith(phoneNoo: phoneNo));
  }

  updateUserProfileInfo(String userId,String accessToken){
    emit(state.copyWith(isProfileUpdatingg: true));
    Map<String,String> map = {
      'userName': state.profileName!,
      'city':state.city!,
      'country': state.country!,
      'phoneNo':state.phoneNo!,
      'gender': state.gender!,
      'martialStatus':state.relationShip!,
      'userId':userId
    };
    repository.updateUserProfileInfo(map, userId, accessToken).then((response){
      emit(state.copyWith(isProfileUpdatingg: false));
      var dec = json.decode(response.body);
      print(dec);
      if(dec['message'] == 'Data successfuly save'){
        Fluttertoast.showToast(msg: "Profile Update Successfully");
      }else{
        Fluttertoast.showToast(msg: "Something went wrong try again");
      }
      fetchMyPRofile(userId, accessToken);
    });
  }



}
