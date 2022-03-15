
import 'dart:io';

import 'package:hapiverse/data/provider/register_provider.dart';
import 'package:http/http.dart';

class RegisterRepository{
  final provider = RegisterProvider();


  Future<Response> loginUser(Map<String, Object> json)async{
    Future<Response> response = provider.loginUser(json);
    return response;
  }
  Future<Response> createProfile(Map<String, String> json,File iamge)async{
    Future<Response> response = provider.createProfile(json,iamge);
    return response;
  }

   Future<Response> getInterests()async{
     Future<Response> response = provider.getCategory();
     return response;
   }
  Future<Response> addSubInterestCat(Map<String,dynamic> map)async{
    Future<Response> response = provider.addSubCatInterest(map);
    return response;
  }

  

}