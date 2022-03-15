import 'dart:io';
import 'package:hapiverse/utils/user_url.dart';
import 'package:http/http.dart' as http;

class RegisterProvider{


  Future<http.Response> loginUser(Map<String,Object> body)async{
    http.Response response = await http.post(
        Uri.parse(loginUrl),
        body: body,
    );
    return response;
  }
  Future<http.Response> createProfile(Map<String,String> body,File image)async{
    var request =  http.MultipartRequest('POST',Uri.parse(createProfileUrl));
    var imagee = await http.MultipartFile.fromPath('profileImageUrl', image.path);
    // request.fields['img'] = image.path.toString();
    request.fields['userName'] = body['userName']!;
    request.fields['email'] = body['email']!;
    request.fields['DOB'] = body['DOB']!;
    request.fields['martialStatus'] = body['martialStatus']!;
    request.fields['gender'] = body['gender']!;
    request.fields['city'] = '';
    request.fields['postCode'] = '';
    request.fields['country'] = body['country']!;
    request.fields['lat'] = body['lat']!;
    request.fields['long'] = body['long']!;
    request.fields['userTypeId'] = '1';
    request.fields['password'] = body['password']!;
    request.fields['phoneNo'] = " ";
    request.fields['address'] = " ";
    request.files.add(imagee);
    // http.StreamedResponse response = await request.send();
    // String respo = '';
    http.Response response = await http.Response.fromStream(await request.send());
    return response;

  }

  Future<http.Response> addSubCatInterest(Map<String,dynamic> map)async{
    http.Response response = await http.post(Uri.parse(addSubCatURl),body: map);
    return response;
  }

  Future<http.Response> getCategory()async{
    http.Response response = await http.post(Uri.parse(getInterestUrl));
    print(response.body);
    return response;
  }


}