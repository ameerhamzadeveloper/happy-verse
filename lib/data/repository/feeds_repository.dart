import 'package:hapiverse/data/provider/feeds_provider.dart';
import 'package:http/http.dart' as http;
class FeedsRepository{
  final provider = FeedsProvider();

  Future<http.Response> sendFriendRequest(Map<String, Object> json,String token)async{
    Future<http.Response> response = provider.sendFriendRequest(json,token);
    return response;
  }

  Future<http.Response> searchUser(String keyword,String userID,String token)async{
    Future<http.Response> response = provider.searchUser(keyword,userID,token,);
    return response;
  }
  Future<http.Response> fetchFeedsPost(String userID,String token)async{
    Future<http.Response> response = provider.fetchFeedsPosts(userID,token,);
    return response;
  }

  Future<http.Response> addLikeDislike(String userID,String token,String postId)async{
    Future<http.Response> response = provider.addLikeDislike(userID,token,postId);
    return response;
  }
}