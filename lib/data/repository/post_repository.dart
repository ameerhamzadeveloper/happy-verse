import 'dart:io';
import 'package:hapiverse/data/provider/post_provider.dart';
import 'package:http/http.dart' as http;

class PostRepository{

  final provider = PostProvider();

  Future<http.Response> getNearbyPlaces(double lat,double long){
    Future<http.Response> res = provider.getNearbyPlaces(lat, long);
    return res;
  }

  Future<http.Response> getPostComments(String postId){
    Future<http.Response> res = provider.getComments(postId);
    return res;
  }

  Future<http.Response> createPost(Map<String, dynamic> json,String token,String userId,
      {List<String>? image, File? videoFile})async{
    Future<http.Response> response = provider.createPost(json,token,userId,image,videoFile);
    return response;
  }

  Future<http.Response> createGroupPost(Map<String, dynamic> json,String token,String userId,
      {List<String>? image, File? videoFile})async{
    Future<http.Response> response = provider.createGroupPost(json,token,userId,image,videoFile);
    return response;
  }


  Future<http.Response> createStoryPost(Map<String,dynamic> body,String accesToken,String userId,
      {File? content})async{
    Future<http.Response> response = provider.postStory(body,accesToken,userId,content: content);
    return response;
  }

}