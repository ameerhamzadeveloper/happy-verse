import 'dart:convert';
import 'dart:io' as Io;
import 'dart:io';
import 'dart:math';
import 'dart:typed_data';
import 'package:bloc/bloc.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:hapiverse/data/model/intrestes_category.dart';
import 'package:hapiverse/data/repository/register_repository.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/model/interest_select_model.dart';
import '../../utils/constants.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit()
      : super(RegisterState(
            errorMessage: '',
            loadingState: false,
            relationVal: relationShip,
            genderVal: gender,
            relationDropList: relationStatusList,
            genderList: genderList,
            dateOfBirth: DateTime.now(),
    isInterseSelect: []
  ),);

  final repository = RegisterRepository();
  late SharedPreferences pre;

  List<IntrestCategory> inters = [];
  List<IntrestCategory> subIn = [];

  String? userID;
  String? accesToken;
  String get userId => userID!;
  String get token => accesToken!;

  double? lat;
  double? long;

  String? hobby;
  DateTime? dateofBirth;
  static String relationShip = "Single";
  static String gender = "Male";
  String base64Image = '';
  String authorizationToken = '';
  String get authToken => authorizationToken;

  static List<String> relationStatusList = [
    'Single',
    'Engaged',
    'Married',
  ];

  changeRelationDrop(val) {
    relationShip = val;
    emit(state.copyWith(relationVall: val));
  }

  static List<String> genderList = [
    'Male',
    'Female',
    'other',
  ];

  changeGenderDrop(val) {
    gender = val;
    emit(state.copyWith(genderVall: val));
  }

  changeDate(DateTime date){
    emit(state.copyWith(dateofB: date));
  }

  getLocation() async {
    await Geolocator.requestPermission();
    await Geolocator.getCurrentPosition().then((value) {
      lat = value.latitude;
      long = value.longitude;
    });
  }

  getInterests() {
    repository.getInterests().then((response) {
      final result = intrestModelFromJson(response.body);
      inters = result.data;
      // subIn = result.data;
      print(result.data);
      emit(state.copyWith(intrestt: result.data, subIntres: subIn));
      // print(state.intrest![1].name);
    });
  }

  List<String> subCatId = [];
  List<String> isInterseSelect = [];


  onIntrestSelect(int i) {
    print("selec");
    debugPrint("cvxv");
    inters[i].isSelect = !inters[i].isSelect;
    emit(state.copyWith(subIntres: subIn));
  }

  onSubIntSelect(int i, int j) {
    inters[i].intrestSubCategory[j].isSelect =
        !inters[i].intrestSubCategory[j].isSelect;
    subCatId.add(inters[i].intrestSubCategory[j].interestSubCategoryId);
    emit(state.copyWith(intrestt: inters));
  }

  List<UserInterest> intt = [];
  List<UserSubInterestDto> subInt = [];

  createProfile(BuildContext context){
    emit(state.copyWith(erro: "",loadingSt: true));
    Map<String,String> mapData = {
      "userName": state.fullName!,
      "email": state.email!,
      "DOB": state.dateOfBirth.toString(),
      "martialStatus": state.relationVal,
      "gender": state.genderVal,
      "country": Platform.localeName,
      "lat": lat.toString(),
      "long": long.toString(),
      "password": state.password!,
    };
    repository.createProfile(mapData, File(state.profileImagePath!)).then((value){
      emit(state.copyWith(loadingSt: false,erro: ""));
      var dec = json.decode(value.body);
      userID = dec['userId'];
      print(dec['userId']);
      print(value.body);
      saveUSerId(dec['userId']);
      if(dec['message'] == "Data successfuly save"){
        print("Well");
        saveUserIntereseSubCat();
        loginUser(context);
        // Navigator.pushNamedAndRemoveUntil(context, loadingPage, (route) => false);
      }else{
        emit(state.copyWith(erro: "Email Already Exist!"));
      }

      // print(value.statusCode);
      // if(value.statusCode == 200){
      //   Navigator.pushNamedAndRemoveUntil(context, nav, (route) => false);
      // }
    });
  }

  imageNotSelected(){
    emit(state.copyWith(erro: "Please Select Profile Image"));
  }

  saveUserIntereseSubCat(){
    Map<String,dynamic> data = {};
    int i = 0;
    subCatId.forEach((element) {
      String interestSubCategoryId = "${element}";
      data['interestSubCategoryId[$i]'] = interestSubCategoryId.toString();
      i++;
    });
    data['userId'] = userID!;
    repository.addSubInterestCat(data).then((value){
      print(value.body);
    });
    print(data);
  }

  FirebaseMessaging fcm = FirebaseMessaging.instance;
  String fcmToken = '';

  getFCM(){
    fcm.getToken().then((value){
      fcmToken = value!;
      print(fcmToken);
    });
  }


  static final DeviceInfoPlugin deviceInfoPlugin = DeviceInfoPlugin();
  Map<String, dynamic> _deviceData = <String, dynamic>{};

  Future<void> initPlatformState() async {
    var deviceData = <String, dynamic>{};

    try {

        if (Platform.isAndroid) {
          deviceData =
              _readAndroidBuildData(await deviceInfoPlugin.androidInfo);
          print(deviceData);
        } else{
          deviceData = _readIosDeviceInfo(await deviceInfoPlugin.iosInfo);
          print(deviceData);
        }
    } on PlatformException {
      deviceData = <String, dynamic>{
        'Error:': 'Failed to get platform version.'
      };
    }


      _deviceData = deviceData;
  }

  Map<String, dynamic> _readAndroidBuildData(AndroidDeviceInfo build) {
    return <String, dynamic>{
      'version.securityPatch': build.version.securityPatch,
      'version.sdkInt': build.version.sdkInt,
      'version.release': build.version.release, //yeah chahye
      'version.previewSdkInt': build.version.previewSdkInt,
      'version.incremental': build.version.incremental,
      'version.codename': build.version.codename,
      'version.baseOS': build.version.baseOS,
      'board': build.board, //yeah chahye
      'bootloader': build.bootloader,
      'brand': build.brand,
      'device': build.device,
      'display': build.display,
      'fingerprint': build.fingerprint,
      'hardware': build.hardware,
      'host': build.host,
      'id': build.id, // yeah chahye
      'manufacturer': build.manufacturer,
      'model': build.model,
      'product': build.product,
      'supported32BitAbis': build.supported32BitAbis,
      'supported64BitAbis': build.supported64BitAbis,
      'supportedAbis': build.supportedAbis,
      'tags': build.tags,
      'type': build.type,
      'isPhysicalDevice': build.isPhysicalDevice,
      'androidId': build.androidId,
      'systemFeatures': build.systemFeatures,
    };
  }

  int getRandom(){
    return Random().nextInt(5000);
  }

  Map<String, dynamic> _readIosDeviceInfo(IosDeviceInfo data) {
    return <String, dynamic>{
      'name': data.name,
      'systemName': data.systemName, //yeah chahye
      'systemVersion': data.systemVersion, // yeah chahye
      'model': data.model,
      'localizedModel': data.localizedModel,
      'identifierForVendor': data.identifierForVendor,
      'isPhysicalDevice': data.isPhysicalDevice,
      'utsname.sysname:': data.utsname.sysname,
      'utsname.nodename:': data.utsname.nodename,
      'utsname.release:': data.utsname.release,
      'utsname.version:': data.utsname.version,
      'utsname.machine:': data.utsname.machine,
    };
  }
 
  intiShared() async {
    pre = await SharedPreferences.getInstance();
  }
  setHobby(String val){
    emit(state.copyWith(hobbyy: val));
  }

  saveUSerId(String id) async {
    pre.setString('id', id);
    getFromShared();
  }

  saveAuthToken(String token) async {
    SharedPreferences pre = await SharedPreferences.getInstance();
    pre.setString('token', token);
    authorizationToken = token;
  }

  getFromShared(){
    // accesToken = pre.getString('token');
    userID = pre.getString('id');
    accesToken = pre.getString('token');
    print("User $userID");
    print("Tojekee $accesToken");
  }

  loginUser(BuildContext context) {
    emit(state.copyWith(erro: '', loadingSt: true));
    Map<String, Object> json = {
      "email": state.email!,
      "password": state.password!,
      "deviceUUID": Io.Platform.isAndroid ? _deviceData['id'] : "asdfdvsd${getRandom()}",
      "deviceName": Io.Platform.isAndroid ? _deviceData['device'] : _deviceData['name'],
      "deviceOS": Io.Platform.isAndroid ? "Android" : "IOS",
      "osVersion": Io.Platform.isAndroid ? _deviceData['version.release'] : _deviceData['systemVersion'],
      "fcmToken": fcmToken,
    };
    repository.loginUser(json).then((value) {
      print(value.body);
      var deco = jsonDecode(value.body);
      if (deco['message'] == 'Data availabe') {
        accesToken = deco['data']['token'];
        saveAuthToken(deco['data']['token']);
        saveUSerId(deco['data']['userId']);
        //valid confition
          Navigator.pushNamedAndRemoveUntil(context, splashNormal, (route) => false);
      } else {
        emit(state.copyWith(erro: "Email or Password incorrect", loadingSt: false));
      }
    });
  }

  assignName(String name) {
    emit(state.copyWith(fullNamee: name));
  }

  assignEmail(String email) {
    emit(state.copyWith(emaill: email));
  }

  assignPassword(String pass) {
    emit(state.copyWith(passwordd: pass));
  }

  static Uint8List? byteimage;


  getImage() async {
    XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
    final bytes = Io.File(image!.path).readAsBytesSync();
    byteimage = await image.readAsBytes();
    base64Image = base64Encode(bytes);
    cropImage(File(image.path));
  }

  Future<Null> cropImage(File imageFile)async{
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: imageFile.path,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9
        ],
        androidUiSettings: const AndroidUiSettings(
            toolbarTitle: 'Crop Image',
            toolbarColor: kUniversalColor,
            toolbarWidgetColor: Colors.white,
            activeControlsWidgetColor: kSecendoryColor,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        iosUiSettings: IOSUiSettings(
          minimumAspectRatio: 1.0,
        )
    );
    emit(state.copyWith(ProfileImagePathset: croppedFile!.path));
  }

}
