import 'dart:io';

import 'package:hapiverse/data/provider/profile_provider.dart';
import 'package:http/http.dart' as http;
class ProfileRepository{

  final provider = ProfileProvider();

  Future<http.Response> getProfile(String userID,String token)async{
    Future<http.Response> response = provider.getMyProfile(userID,token);
    return response;
  }

  Future<http.Response> getOtherProfile(String userID,String token,String myUserId)async{
    Future<http.Response> response = provider.getOtherProfile(myUserId,userID,token,);
    return response;
  }
  Future<http.Response> getOtherAllPorst(String userID,String token,String myUserId)async{
    Future<http.Response> response = provider.getOtherAllPosts(myUserId,userID,token,);
    return response;
  }

  Future<http.Response> addFollower(String followerId,String token,String myUserId)async{
    Future<http.Response> response = provider.addFollower(myUserId,followerId,token,);
    return response;
  }

  Future<http.Response> fetchMyPosts(String token,String myUserId)async{
    Future<http.Response> response = provider.fetchMyPosts(myUserId,token,);
    return response;
  }
  Future<http.Response> getFriendList(String userID,String token)async{
    Future<http.Response> response = provider.getFriendList(userID,token);
    return response;
  }

  Future<http.Response> editUserProfileImage(String userId,File image,String token,)async{
    Future<http.Response> response = provider.editProfileImage(userId,image,token);
    return response;
  }

  Future<http.Response> updateUserProfileInfo(Map<String,String> map,String userID,String token)async{
    Future<http.Response> response = provider.editProfileInfo(map,userID,token,);
    return response;
  }



}