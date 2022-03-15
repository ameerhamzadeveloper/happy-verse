part of 'profile_cubit.dart';


class ProfileState {

  String? profileName;
  String? profileImage;
  String? gender;
  String? relationShip;
  String? hobby;
  String? country;
  String? city;
  String? totalPost;
  String? followers;
  String? following;
  String? dateOfBirth;
  String? phoneNo;
  List<String> genderList;
  List<String> relationDropList;
  Response? otherProfileInfoResponse;
  List<GetMyAllPosts>? allOtherPosts;
  List<GetMyAllPosts>? allMyPosts;
  File? profileUpdatedImage;
  bool isProfileUpdating;
  String? isFriend;

  ProfileState({
    this.profileImage,
    this.profileName,
    this.hobby,
    this.relationShip,
    this.gender,
    this.country,
    this.city,
    this.followers,
    this.following,
    this.totalPost,
    this.dateOfBirth,
    this.phoneNo,
    required this.genderList,
    required this.relationDropList,
    this.otherProfileInfoResponse,
    this.allOtherPosts,
    this.profileUpdatedImage,
    required this.isProfileUpdating,
    this.allMyPosts,
    this.isFriend
});

  ProfileState copyWith({
    String? profileNamee,
    String? profileImagee,
    String? genderr,
    String? relationShipp,
    String? hobbyy,
    String? countryy,
    String? cityy,
    String? totalPostt,
    String? followerss,
    String? followingg,
    String? dateOfBirt,
    String? phoneNoo,
    List<String>? genderListt,
    List<String> ?relationDropListt,
    Response? otherProfileInfoResponsee,
    List<GetMyAllPosts>? allOtherPostss,
    File? profileUpdatedImagee,
    bool? isProfileUpdatingg,
    List<GetMyAllPosts>? allMyPostss,
    String? isFriendd,

}){
    return ProfileState(
       hobby: hobbyy ?? hobby,
      city: cityy ?? city,
      country: countryy ?? country,
      followers: followerss ?? followers,
      following: followingg ?? following,
      gender: genderr ?? gender,
      profileImage: profileImagee ?? profileImage,
      profileName: profileNamee ?? profileName,
      relationShip: relationShipp ?? relationShip,
      totalPost: totalPostt ?? totalPost,
      dateOfBirth: dateOfBirt ?? dateOfBirth,
      phoneNo: phoneNoo ?? phoneNo,
      genderList: genderListt ?? genderList,
      relationDropList: relationDropListt ?? relationDropList,
      otherProfileInfoResponse: otherProfileInfoResponsee ?? otherProfileInfoResponse,
      allOtherPosts: allOtherPostss ?? allOtherPosts,
      profileUpdatedImage: profileUpdatedImagee ?? profileUpdatedImage,
      isProfileUpdating: isProfileUpdatingg ?? isProfileUpdating,
      allMyPosts: allMyPostss ?? allMyPosts,
      isFriend: isFriendd ?? isFriend,
    );
}

}
