import 'dart:io';
import 'package:hapiverse/utils/user_url.dart';
import 'package:http/http.dart' as http;

class PostProvider{

  Future<http.Response> getNearbyPlaces(double lat,double long)async{
    String uri = "https://maps.googleapis.com/maps/api/place/nearbysearch/json?location=$lat,$long&radius=500&key=AIzaSyBVY5x_t23MvVUr-d3sdb28yuBPXofAF5A";
    http.Response res = await http.get(Uri.parse(uri));
    return res;
  }

  Future<http.Response> getComments(String postId)async{
    String uri = "https://jsonplaceholder.typicode.com/posts/1/comments";
    http.Response res = await http.get(Uri.parse(uri));
    return res;
  }

  Future<http.Response> createPost(Map<String,dynamic> body,String accesToken,String userID,List<String>? files,File? videoFile)async{
    var request = http.MultipartRequest('POST',Uri.parse(createPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['postContentText'] = body['postContentText'];
    print(body['privacy']);
    if(body['postType'] == 'video'){
      var multipartFile = await http.MultipartFile.fromPath("postFileUrl[]",
          videoFile!.path);
      request.files.add(multipartFile);
    }else if(body['postType'] != 'video'){
      for (int i = 0; i < files!.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath("postFileUrl[]",
            files[i]);
        request.files.add(multipartFile);
      }
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> createGroupPost(Map<String,dynamic> body,String accesToken,String userID,List<String>? files,File? videoFile)async{
    var request = http.MultipartRequest('POST',Uri.parse(createGroupPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['postContentText'] = body['postContentText'];
    request.fields['groupId'] = body['groupId'];
    print(body['privacy']);
    if(body['postType'] == 'video'){
      var multipartFile = await http.MultipartFile.fromPath("postFileUrl[]",
          videoFile!.path);
      request.files.add(multipartFile);
    }else if(body['postType'] != 'video'){
      for (int i = 0; i < files!.length; i++) {
        var multipartFile = await http.MultipartFile.fromPath("postFileUrl[]",
            files[i]);
        request.files.add(multipartFile);
      }
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> postStory(Map<String,dynamic> body,String accesToken,String userID,
      {File? content})async{
    var request = http.MultipartRequest('POST',Uri.parse(createPostUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['caption'] = body['caption'] ?? "";
    request.fields['privacy'] = body['privacy'];
    request.fields['content_type'] = body['content_type']!;
    request.fields['postType'] = body['postType']!;
    request.fields['font_color'] = body['font_color'];
    request.fields['text_back_ground'] = body['text_back_ground'];
    request.fields['posted_date'] = DateTime.now().toString();
    request.fields['expire_at'] = body['expire_at']!;
    request.fields['interest'] = '';
    request.fields['location'] = body['location'];
    request.fields['active'] = '1';
    request.fields['postContentText'] = body['postContentText'];
    print(body['privacy']);
    if(body['postType'] == 'text'){

    }else{
      var multipartFile = await http.MultipartFile.fromPath("postFileUrl[]",
          content!.path);
      request.files.add(multipartFile);
    }
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }


}