import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:hapiverse/data/provider/group_provider.dart';

class GroupRepository{
  final provider = GroupProvider();

  Future<http.Response> createGroup(Map<String, dynamic> map,String accesToken,String userID,File? groupCover){
    Future<http.Response> response = provider.createGroup(map,accesToken,userID,groupCover);
    return response;
  }

  Future<http.Response> getGroups(String accesToken,String userID){
    Future<http.Response> response = provider.getGroups(userID,accesToken,);
    return response;
  }

  addGropPost(Map<String,dynamic> map,String groupId){
    provider.addGropPost(map, groupId);
  }
}