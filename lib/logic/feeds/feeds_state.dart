part of 'feeds_cubit.dart';


class FeedsState {

  String? translatedText;
  String? searchText;
  TextEditingController searchController;
  List<SearchedUsers>? searchedUsersList;
  bool isSearching = false;
  List<FeedsPosts>? feedsPost;
  List<StoryModel>? storyList;

  FeedsState({this.translatedText,this.searchText,
    required this.searchController,this.searchedUsersList,required this.isSearching,
  this.feedsPost,this.storyList});

  FeedsState copyWith({
    String? translatedTextt,
    String? searchTextt,
    TextEditingController? searchControllerr,
    List<SearchedUsers>? searchedUsersListt,
    bool? isSearchingg,
    List<FeedsPosts>? feedsPostt,
    List<StoryModel>? storylistt,
}){
    return FeedsState(
      translatedText: translatedTextt ?? translatedText,
      searchText: searchTextt ?? searchText,
      searchController: searchControllerr ?? searchController,
      searchedUsersList: searchedUsersListt ?? searchedUsersList,
      isSearching: isSearchingg ?? isSearching,
      feedsPost: feedsPostt ?? feedsPost,
      storyList: storylistt ?? storyList
    );
}

}
