import 'package:hapiverse/utils/user_url.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../utils/utils.dart';
class FeedsProvider{

  Future<http.Response> sendFriendRequest(Map<String,Object> body,String accesToken)async{
    http.Response response = await http.post(
        Uri.parse(friendRequestURL),
        body: json.encode(body),
        headers: {
          'Token': Utils.token,
          'Content-Type':'application/json',
          'Authorization' : accesToken
        }
    );
    return response;
  }

  Future<http.Response> searchUser(String keyWord,String userId,String token)async{
    String uri = searchUSersUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'keyword':keyWord,
          'userId':userId,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> fetchFeedsPosts(String userId,String token)async{
    String uri = feedsPostsUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }

  Future<http.Response> addLikeDislike(String userId,String token,String postId)async{
    String uri = addLikeDislikeUrl;
    http.Response res = await http.post(
        Uri.parse(uri),
        body: {
          'userId':userId,
          'postId': postId,
        },
        headers: {
          'token': token,
          'userId': userId,
        }
    );
    return res;
  }
}