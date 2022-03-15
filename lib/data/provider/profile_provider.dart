import 'dart:io';

import 'package:hapiverse/utils/user_url.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:http/http.dart' as http;

class ProfileProvider{

  Future<http.Response> getMyProfile(String userID,String token)async{
    String uri = getProfileURL;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'myId': userID,
          'userId': userID,
        },
        headers: {
          'token': token,
          'userId': userID,
        }
    );
    return res;
  }

  Future<http.Response> getOtherProfile(String myUserId,String userId,String token)async{
    String uri = getProfileURL;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userId,
          'myId':myUserId,
        },
        headers: {
          'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> getOtherAllPosts(String myUserId,String userId,String token)async{
    String uri = getMyAllPostsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': userId,
        },
        headers: {
          'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> addFollower(String myUserId,String followerId,String token)async{
    String uri = addFollowerUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': myUserId,
          'followerId': followerId,
        },
        headers: {
          'token': token,
          'userId': followerId,
        }
    );
    return res;
  }

  Future<http.Response> fetchMyPosts(String myUserId,String token)async{
    String uri = getMyAllPostsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId': myUserId,
        },
        headers: {
          'token': token,
          'userId': myUserId,
        }
    );
    return res;
  }

  Future<http.Response> getFriendList(String userID,String accesToken)async{
    String uri = "$getFriendListUrl?Userid=$userID";
    http.Response response = await http.get(
        Uri.parse(uri),
        headers: {
          'Token': Utils.token,
          'Content-Type':'application/json',
          'Authorization' : accesToken
        }
    );
    return response;
  }

  Future<http.Response> editProfileImage(String userId,File image,String token)async{
    var request =  http.MultipartRequest('POST',Uri.parse(updateMyProfileUrl));
    var imagee = await http.MultipartFile.fromPath('profileImageUrl', image.path);
    request.fields['userId'] = userId;
    request.files.add(imagee);
    request.headers['userId'] = userId;
    request.headers['token'] = token;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;

  }

  Future<http.Response> editProfileInfo(Map<String,String> map,String userId,String token)async{
    String uri = updateMyProfileUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: map,
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }


}