part of 'groups_cubit.dart';

class GroupsState {
  List<String> privacyDownValue;
  String privacyValue;
  String? groupName;
  File? groupCover;
  String error;
  bool isSub;
  String? caption;
  List<Groups>? groups;
  bool isGroupLoading = true;
  List<Groups>? searchGroups = [];

  GroupsState(
      {required this.privacyDownValue,
      required this.privacyValue,
      this.groupName,
      this.groupCover,
      required this.error,
      required this.isSub,
      this.caption,
        this.groups,
        required this.isGroupLoading,
        this.searchGroups
      });

  GroupsState copyWith({
    List<String>? privacyDownValuee,
    String? privacyValuee,
    String? groupNamee,
    File? groupCoverr,
    String? errorr,
    bool? isSubb,
    String? captionn,
    List<Groups>? groupss,
    bool? isGroupLoadingg,
    List<Groups>? searchGroupss,
  }) {
    return GroupsState(
        privacyDownValue: privacyDownValuee ?? privacyDownValue,
        privacyValue: privacyValuee ?? privacyValue,
        groupName: groupNamee ?? groupName,
        groupCover: groupCoverr ?? groupCover,
      error: errorr ?? error,
      isSub: isSubb ?? isSub,
      caption: captionn ?? caption,
      groups: groupss ?? groups,
      isGroupLoading: isGroupLoadingg ?? isGroupLoading,
      searchGroups: searchGroupss ??searchGroups
    );
  }
}
