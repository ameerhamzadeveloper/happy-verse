import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/data/model/feeds_card.dart';
import 'package:hapiverse/data/model/interest_select_model.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/feeds/components/friends_suggestion_widget.dart';
import 'package:hapiverse/views/feeds/components/loading_story_widget.dart';
import 'package:hapiverse/views/feeds/components/my_post_image_widget.dart';
import 'package:hapiverse/views/feeds/components/post_widget.dart';
import 'package:hapiverse/views/feeds/components/text_feed_widget.dart';
import 'package:hapiverse/views/feeds/components/video_post_card.dart';
import 'package:hapiverse/views/feeds/post/add_post.dart';
import 'package:hapiverse/views/feeds/components/add_story_widget.dart';
import 'package:hapiverse/views/feeds/components/story_widget.dart';
import 'package:hapiverse/views/feeds/story/story_view.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_icons/line_icons.dart';

import '../../logic/register/register_cubit.dart';
import '../../utils/config/assets_config.dart';
import 'components/loading_post_widget.dart';

class FeedsPage extends StatefulWidget {
  const FeedsPage({Key? key}) : super(key: key);
  @override
  _FeedsPageState createState() => _FeedsPageState();
}

class _FeedsPageState extends State<FeedsPage> {

  String text = "Good Morning";
  DateTime d = DateTime.now();
  // if(d.hour);

 @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
   final bloc = context.read<FeedsCubit>();
   final authB = context.read<RegisterCubit>();
   final postBloc = context.read<PostCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, profileState) {
    return BlocBuilder<PostCubit, PostState>(
  builder: (context, postState) {
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      body: RefreshIndicator(
        onRefresh: (){
          return bloc.fetchFeedsPosts(authB.userID!, authB.accesToken!);
        },
        child: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              floating: true,
              backgroundColor: kScaffoldBgColor,
              leading: Container(),
              expandedHeight: 100.0,
              leadingWidth: 10,
              centerTitle: false,
              title:BlocBuilder<ProfileCubit,ProfileState>(
                  builder: (context,state) {
                      return const Text(
                        "Hapiverse",
                          // state.profileName == null ? "...":state.profileName!.length > 10 ? "${state.profileName!.substring(0,10)}..":state.profileName!,
                        style: const TextStyle(
                          color: kUniversalColor,
                          fontWeight: FontWeight.bold
                        ),
                      );
                  }
              ),
              flexibleSpace: FlexibleSpaceBar(
                centerTitle: true,
                title: Text(
                    getTranslated(context, 'EXPLORE_TODAY')!,
                  textScaleFactor: 1,
                  style: TextStyle(color: Colors.black, fontSize: 14),
                ),
              ),
              actions: [
                IconButton(
                    onPressed: () {
                      Navigator.pushNamed(context, searchPage);
                    },
                    icon: const Icon(
                      Icons.search,
                      color: Colors.black,
                    )),
                IconButton(
                    onPressed: () => Navigator.pushNamed(context, notifications),
                    icon: const Icon(
                      LineIcons.bell,
                      color: Colors.black,
                    ),
                ),
              ],
            ),
            SliverToBoxAdapter(
              child: state.storyList == null || state.storyList!.isEmpty ? LoadingStoryWidget():_storyWidget(),
            ),
            SliverToBoxAdapter(
              child: BlocBuilder<PostCubit,PostState>(
                builder: (context,state) {
                  if(state.isUploaded == null || state.isUploaded! == true){
                    return Container();
                  }else{
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: const [
                          Text("Post Uploading...."),
                          SizedBox(height: 5,),
                          LinearProgressIndicator()
                        ],
                      ),
                    );
                  }
                }
              ),
            ),
            postState.isUploaded == false || postState.isUploaded == null ? SliverToBoxAdapter():
            SliverAnimatedList(
              initialItemCount: 1,
              itemBuilder: (ctx,i,animation){
                  if(postBloc.getPostType() == 'text'){
                    return SizeTransition(
                        sizeFactor: animation,
                        child: TextFeedsWidget(
                          userId: authB.userID!,
                          commentOntap: (){},
                          postId: "posts[i].docId",
                          onTap: (){},
                          name: postState.showText!,
                          bgImage: postState.postBGImage!,
                          commentCount: '0',
                          date: DateTime.now(),
                          likeCount: '0',
                          profileName: profileState.profileName!,
                          profilePic: "${Utils.baseImageUrl}${profileState.profileImage}",
                        )
                    );
                  }else if(postBloc.getPostType() == 'video'){
                    return SizeTransition(
                      sizeFactor: animation,
                      child: VideoPostCard(
                        isLiked: false,
                        postId: "posts[i].docId",
                        name: postState.postController.text,
                        iamge: postState.videoFilePath!,
                        date: DateTime.now(),
                        commentCount: '0',
                        likeCount: '0',
                        profileName: profileState.profileName!,
                        profilePic: "${Utils.baseImageUrl}${profileState.profileImage}",
                        videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        userId: authB.userID!,
                        index: i,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, "d.postId!", i);
                        },
                      ),
                    );
                  }else{
                    return SizeTransition(
                      sizeFactor: animation,
                      child: MyPostImageWidget(
                        postId: "",
                        name: postState.showText!,
                        date: DateTime.now(),
                        commentCount: '0',
                        likeCount: '0',
                        profileName: profileState.profileName!,
                        profilePic: "${Utils.baseImageUrl}${profileState.profileImage}",
                        isLiked: false,
                        index: i,
                        userId: authB.userID!,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, "d.postId!", i);
                        },
                      ),
                    );
                  }
              },
            ),
            state.feedsPost == null || state.feedsPost!.isEmpty ? SliverToBoxAdapter(child: LoadingPostWidget()):
            SliverAnimatedList(
              itemBuilder: (ctx,i,animation){
                var d = state.feedsPost![i];
                // if(i == 1){
                //   return Card(
                //     child: Padding(
                //       padding: const EdgeInsets.symmetric(horizontal: 8.0),
                //       child: Column(
                //         crossAxisAlignment: CrossAxisAlignment.start,
                //         children: [
                //           const Text("Peoples you may know"),
                //           SingleChildScrollView(
                //             scrollDirection: Axis.horizontal,
                //             child: Row(
                //               children: List.generate(4, (index){
                //                 return const FriendSuggestionWidget();
                //               }),
                //             ),
                //           ),
                //         ],
                //       ),
                //     ),
                //   );
                // }else{
                  if(state.feedsPost![i].postType == 'image'){
                    return SizeTransition(
                      sizeFactor: animation,
                      child: PostWidget(
                        postId: d.postId!,
                        name: d.caption!,
                        iamge: d.postFiles!,
                        date: d.postedDate!,
                        commentCount: d.totalComment.toString(),
                        likeCount: d.totalLike.toString(),
                        profileName: d.userName!,
                        profilePic: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        isLiked: d.isLiked!,
                        index: i,
                        userId: d.userId!,
                        onLikeTap: (){

                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i);
                        },
                      ),
                    );
                  }else if(state.feedsPost![i].postType == 'text'){
                    return SizeTransition(
                        sizeFactor: animation,
                        child: TextFeedsWidget(
                          userId: d.userId!,
                          commentOntap: (){},
                          postId: "posts[i].docId",
                          onTap: (){},
                          name: d.postContentText!,
                          bgImage: d.textBackGround!,
                          commentCount: d.totalComment.toString(),
                          date: d.postedDate!,
                          likeCount: d.totalLike.toString(),
                          profileName: d.userName!,
                          profilePic: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        )
                    );
                  }else{
                    return SizeTransition(
                      sizeFactor: animation,
                      child: VideoPostCard(
                        isLiked: d.isLiked!,
                        postId: "posts[i].docId",
                        name: d.caption!,
                        iamge: "${Utils.baseImageUrl}${d.postFiles![0].postFileUrl}",
                        date: d.postedDate!,
                        commentCount: d.totalComment.toString(),
                        likeCount: d.totalLike.toString(),
                        profileName:d.userName!,
                        profilePic: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        videothumb: "${Utils.baseImageUrl}26986e6069f11685de65a0cb8580036a.jpg",
                        userId: d.userId!,
                        index: i,
                        onLikeTap: (){
                          bloc.addLikeDislike(authB.userID!, authB.accesToken!, d.postId!, i);
                        },
                      ),
                    );
                  }
                },
              initialItemCount: state.feedsPost!.length,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          nextScreen(context, const AddPostPage(isFromGroup: false,));
        },
        child: const Icon(Icons.add),
        backgroundColor: kSecendoryColor,
      ),
    );
  },
);
  },
);
  },
);
  }

  Widget postWidget(){
   return ListView.builder(
     physics: const NeverScrollableScrollPhysics(),
     shrinkWrap: true,
     itemCount: 5,
     itemBuilder: (ctx,i){
       if(i == 1){
         return Card(
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
               crossAxisAlignment: CrossAxisAlignment.start,
               children: [
                 const Text("Peoples you may know"),
                 SingleChildScrollView(
                   scrollDirection: Axis.horizontal,
                   child: Row(
                     children: List.generate(4, (index){
                       return const FriendSuggestionWidget();
                     }),
                   ),
                 ),
               ],
             ),
           ),
         );
       }else{
         return Container();
         // return PostWidget(
         //   collid: '',
         //   name: "Ameer Hamza",
         //   iamge: image,
         //   date: "12 Dec 2022 at 12:47 AM",
         //   commentCount: '18',
         //   likeCount: '12k',
         //   profileName: "John Doe",
         //   profilePic: image,
         // );
       }
     },
   );
  }

  Widget _storyWidget() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
        const AddStoryWidget(),
        BlocBuilder<FeedsCubit,FeedsState>(
          builder: (context,state){
            return SizedBox(
              height: 80,
              child: ListView.builder(
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemCount: state.feedsPost!.length,
                itemBuilder: (ctx,i){
                  return StoryWidget(
                    image: state.storyList![i].profileImage,
                    title: state.storyList![i].date,
                    index: i,
                  );
                },
              ),
            );
          },
        )
        // SingleChildScrollView(
        //   child: Row(
        //     children: List.generate(
        //         5,
        //         (index) => InkWell(
        //           onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=> const StoryViewPage())),
        //           child: StoryWidget(
        //               image: image, title: 'story'),
        //         ),
        //     ),
        //   ),
        // )
      ]),
    );
  }
}
