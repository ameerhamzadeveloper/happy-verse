part of 'register_cubit.dart';

class RegisterState {
  String? fullName;
  String? email;
  String? password;
  String errorMessage;
  bool loadingState;
  List<IntrestCategory>? intrest;
  List<IntrestCategory>? subIntrest;
  String? profileImagePath;
  List<String> genderList;
  List<String> relationDropList;
  String genderVal;
  String relationVal;
  DateTime dateOfBirth;
  String? hobby;
  List<String>? isInterseSelect = [];


  RegisterState(
      {this.fullName,
      this.email,
      this.password,
      required this.errorMessage,
      required this.loadingState,
      this.intrest,
      this.subIntrest,
      this.profileImagePath,
      required this.genderList,
      required this.genderVal,
      required this.relationDropList,
      required this.relationVal,
      required this.dateOfBirth,
        this.hobby,
        this.isInterseSelect
      });

  RegisterState copyWith({
    String? fullNamee,
    String? emaill,
    String? passwordd,
    String? erro,
    bool? loadingSt,
    List<IntrestCategory>? intrestt,
    List<IntrestCategory>? subIntres,
    String? ProfileImagePathset,
    String? genderVall,
    String? relationVall,
    DateTime? dateofB,
    String? hobbyy,
    List<String>? isInterseSelectt
  }) {
    return RegisterState(
      email: emaill ?? email,
      fullName: fullNamee ?? fullName,
      password: passwordd ?? password,
      errorMessage: erro ?? errorMessage,
      loadingState: loadingSt ?? loadingState,
      intrest: intrestt ?? intrest,
      subIntrest: subIntres ?? subIntrest,
      profileImagePath: ProfileImagePathset ?? profileImagePath,
      genderList: genderList,
      genderVal: genderVall ?? genderVal,
      relationDropList: relationDropList,
      relationVal: relationVall ?? relationVal,
      dateOfBirth: dateofB ?? dateOfBirth,
      hobby: hobbyy ?? hobby,
      isInterseSelect: isInterseSelectt ?? isInterseSelect
    );
  }
}
