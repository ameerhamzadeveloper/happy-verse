import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hapiverse/data/model/feeds_post_model.dart';
import 'package:hapiverse/data/repository/feeds_repository.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:jiffy/jiffy.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/story_view.dart';
import 'package:translator/translator.dart';

import '../../data/model/search_user_model.dart';
import '../../data/model/story_model.dart';

part 'feeds_state.dart';

class FeedsCubit extends Cubit<FeedsState> {
  FeedsCubit() : super(FeedsState(searchController: searchController,isSearching: false));

  static TextEditingController searchController = TextEditingController();

  final repository = FeedsRepository();

  sendFriendRequest(String userId,String targetID,String token){
    Map<String,Object> map = {
      "userId": userId,
      "friendRequestById": targetID,
      "active": true,
      "id": 0
    };
    repository.sendFriendRequest(map, token).then((response){
      print(response.body);
    });
  }

  final translator = GoogleTranslator();

  String? languageCode;

  getSharedLanguageCode()async{
    SharedPreferences pre = await SharedPreferences.getInstance();
    var cLan = pre.getInt('language');
    if(cLan == 0){
      languageCode = 'en';
    }else if(cLan == 1){
      languageCode = 'zh';
    }else if(cLan == 2){
      languageCode = 'ar';
    }else if(cLan == 3){
      languageCode = 'ur';
    }else if(cLan == 4){
      languageCode = 'hi';
    }
    else if(cLan == 5){
      languageCode = 'es';
    }
  }

  translateText(String text){
    translator.translate(text, to: languageCode!).then((translated){
      print(translated);
      emit(state.copyWith(translatedTextt: translated.text));
    });
  }

  assignSearchText(String searchVal){
    searchController = TextEditingController(text: searchVal);
    emit(state.copyWith(searchTextt: searchVal));
  }

  assignSearchNull(){
    emit(state.copyWith(searchTextt: "",searchControllerr: TextEditingController(text: "")));
  }

  addSearchText(String val){
    emit(state.copyWith(searchTextt: val,searchControllerr: TextEditingController(text: val)));
  }

  searchUser(String userId,String token){
    emit(state.copyWith(isSearchingg: true));
    repository.searchUser(state.searchText!, userId, token).then((response){
      var data = searchUserModelFromJson(response.body);
      emit(state.copyWith(searchedUsersListt: data.data,isSearchingg: false));
    });
  }
  List<FeedsPosts>? feedsPosttt = [];
  Future<void> fetchFeedsPosts(String userId,String token)async{
    repository.fetchFeedsPost(userId, token).then((response){
      var data = feedsPostsModelFromJson(response.body);
      feedsPosttt = data.data;
      emit(state.copyWith(feedsPostt: data.data));
      initStories();
    });
  }

  addLikeDislike(String userId,String token,String postId,int index){
    if(feedsPosttt![index].isLiked == true){
      feedsPosttt![index].isLiked = false;
      feedsPosttt![index].totalLike = (int.parse(feedsPosttt![index].totalLike!) - 1).toString();
    }else{
      feedsPosttt![index].isLiked = true;
      feedsPosttt![index].totalLike = (int.parse(feedsPosttt![index].totalLike!) + 1).toString();
    }
    emit(state.copyWith(feedsPostt: feedsPosttt));
    repository.addLikeDislike(userId, token, postId).then((response){
      print(response.body);
    });
  }

  hidePost(int index){
    feedsPosttt!.removeAt(index);
    Fluttertoast.showToast(msg: "Post Hided");
    emit(state.copyWith(feedsPostt: feedsPosttt));
  }

  static List<Color> pageColors = [
    Colors.redAccent,
    Colors.green,
    Colors.brown,
    Colors.purpleAccent,
    Colors.deepPurpleAccent
  ];
  Color getTextColor(int textIndex){
    switch (textIndex){
      case 0:
        return Colors.redAccent;
      case 1:
        return Colors.green;
      case 2:
        return Colors.brown;
      case 3:
        return Colors.purpleAccent;
      default:
        return Colors.deepPurpleAccent;
    }
  }

  List<StoryModel> storyList = [];
  List<StoryItem> storyItem = [];
  StoryController controller = StoryController();

  initStories(){
    for(int i = 0; i < feedsPosttt!.length; i++){
      storyItem = [];
      for(int j = 0; j< feedsPosttt![i].postFiles!.length;j++) {
        print("filee lemggth ${feedsPosttt![i].postFiles!.length}");
        storyItem.add(feedsPosttt![i].postType! == 'text'
            ?
        StoryItem.text(
            backgroundColor: getTextColor(0), title: feedsPosttt![i].caption!)
            : feedsPosttt![i].postType! == 'video' ?
        StoryItem.pageVideo(
            "${Utils.baseImageUrl}${feedsPosttt![i].postFiles![j].postFileUrl}",
            controller: controller) : StoryItem.pageImage(
            url: "${Utils.baseImageUrl}${feedsPosttt![i].postFiles![j]
                .postFileUrl}", controller: controller),);
      }
      storyList.add(
          StoryModel(
              controller: controller,
              storyItem: storyItem,
              profileImage: "https://images.pexels.com/photos/771742/pexels-photo-771742.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
              date: Jiffy(feedsPosttt![i].postedDate, "MM dd, yyyy at hh:mm a").fromNow().toString(),
              title: feedsPosttt![i].userName!
          )
      );
      emit(state.copyWith(storylistt: storyList));
      print(storyList[0].storyItem.length);
    }
  }

}
