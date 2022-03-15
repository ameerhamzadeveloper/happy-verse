import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:hapiverse/utils/user_url.dart';
import 'package:http/http.dart' as http;
class GroupProvider{

  Future<http.Response> createGroup(Map<String,dynamic> body,String accesToken,String userID,File? groupCover)async{
    var request = await http.MultipartRequest('POST',Uri.parse(createGroupUrl));
    request.fields['userId'] = body['userId']!;
    request.fields['groupName'] = body['groupName'] ?? "";
    request.fields['groupPrivacy'] = body['groupPrivacy']!;
    var multipartFile = await http.MultipartFile.fromPath("groupImageUrl",
        groupCover!.path);
    request.files.add(multipartFile);
    request.headers['userId'] = userID;
    request.headers['token'] = accesToken;
    http.Response response = await http.Response.fromStream(await request.send());
    return response;
  }

  Future<http.Response> getGroups(String userId,String accessToken)async{
    Uri url = Uri.parse(getGroupUrl);
    http.Response response = await http.post(
        url,body: {'userId':userId},
      headers: {
          'userId':userId,
          'token': accessToken,
      }
    );
    return response;
  }


  Future<bool> addGropPost(Map<String,dynamic> map,String groupId) async {
    final CollectionReference ref = FirebaseFirestore.instance.collection('groupPosts');
    // final CollectionReference comRef = FirebaseFirestore.instance.collection('userPosts').doc(map['phone']).collection('comments');
    var snapshot = await FirebaseStorage.instance.ref().child('Posts Pictures').child('/${DateTime.now().toString()}').putData(map['image']);
    var url = (await snapshot.ref.getDownloadURL()).toString();
    var userData = {
      'title': map['title'],
      'image_url': url,
      'like': 0,
      'share': 0,
      'comments':0,
      'timestamp': DateTime.now(),
      'email': map['email'],
      'profileImage': map['profileImage'],
      'profileName':map['profileName'],
      'PostId':groupId
    };
    await ref.add(userData).then((value){
      print("Posted");
    });
    return true;
  }

}