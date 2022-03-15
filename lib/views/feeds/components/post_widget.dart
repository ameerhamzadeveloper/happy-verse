import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hapiverse/data/model/feeds_post_model.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/feeds/comments_page.dart';
import 'package:hapiverse/views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:share_plus/share_plus.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../utils/constants.dart';
import 'package:flutter_share/flutter_share.dart';

import '../../profile/see_profile_image.dart';
class PostWidget extends StatelessWidget {
  String name;
  List<PostFile> iamge;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  String userId;
  final VoidCallback? onLikeTap;
  final VoidCallback? commentOntap;
  final bool isLiked;
  int index;

  PostWidget({required this.name,required this.iamge,
    required this.date,required this.commentCount,
    required this.likeCount,required this.profileName,
    required this.profilePic,required this.postId,this.onLikeTap,this.commentOntap,
    required this.isLiked,required this.index,required this.userId});
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    var color = Colors.grey[300];
    final feedsBloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20)),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap:() {
                      profileBloc.fetchOtherProfile(userId, authBloc.accesToken!,authBloc.userID!);
                      profileBloc.fetchOtherAllPost(userId, authBloc.accesToken!,authBloc.userID!);
                      nextScreen(context, OtherProfilePage(userId: userId));
                    },
                    child: Row(
                      children: [
                        CircleAvatar(
                          backgroundImage: NetworkImage(profilePic),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              profileName,
                              style: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 20),
                            ),
                            Text(
                              "${dF.format(date)} at ${tF.format(date)}",
                              style: TextStyle(color: kSecendoryColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          context: context, builder: (context){
                          return Container(
                            height: 300,
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              children: [
                                Container(
                                  width: 40,
                                  height: 5,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: color,
                                  ),
                                ),
                                SizedBox(height: 20,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Row(
                                    children: [
                                      Expanded(child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: color
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(LineIcons.link),
                                              Text("Copy Link")
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: color
                                        ),
                                        child: Center(
                                          child: Column(
                                            children: [
                                              Icon(LineIcons.exclamationCircle,color: Colors.red,),
                                              Text("Report")
                                            ],
                                          ),
                                        ),
                                      ),
                                      ),
                                      SizedBox(width: 10,),
                                      Expanded(child: Container(
                                        padding: EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10),
                                            color: color
                                        ),
                                        child: InkWell(
                                          onTap:(){
                                            Share.share("$name \n\n$iamge \nhttps://play.google.com/store/apps/details?id=com.app.hapiverse/feeds/");
                                          },
                                          child: Center(
                                            child: Column(
                                              children: [
                                                Icon(LineIcons.shareSquare),
                                                Text("Share")
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: color,
                                    ),
                                    padding: EdgeInsets.all(12),
                                    child: Center(child: Text("Why you're seeing this post")),
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Container(
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: color,
                                    ),
                                    padding: const EdgeInsets.all(12),
                                    child: Column(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: InkWell(
                                            onTap: (){
                                              feedsBloc.hidePost(index);
                                              // state.feedsPost!.removeAt(index);
                                              Navigator.pop(context);
                                            },
                                            child: Container(
                                              width: double.infinity,
                                              decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(10),
                                                color: color,
                                              ),
                                              padding: EdgeInsets.all(12),
                                              child: Center(child: Text("Hide")),
                                            ),
                                          ),
                                        ),
                                        const Divider(),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                          child: Container(
                                            width: double.infinity,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(10),
                                              color: color,
                                            ),
                                            padding: EdgeInsets.all(12),
                                            child: Center(child: Text("Unfollow")),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        );
                      },
                      icon: Icon(Icons.keyboard_arrow_down_outlined))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            StaggeredGrid.count(
              crossAxisCount: iamge.length == 1 ? 1 : 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 12,
              children: iamge.map((e){
                return InkWell(
                  onTap: (){
                    nextScreen(context, SeeProfileImage(imageUrl: "${Utils.baseImageUrl}${e.postFileUrl}",title: profileName,));
                  },
                  child: Container(
                    decoration: const BoxDecoration(
                      color: Colors.transparent,
                      borderRadius: BorderRadius.all(
                        Radius.circular(15),
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: const BorderRadius.all(
                            Radius.circular(15)),
                        child: Image.network("${Utils.baseImageUrl}${e.postFileUrl}")
                    ),
                  ),
                );
              }).toList(),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name),
                  state.translatedText == null ? Container():
                  Text(state.translatedText!),
                  name == null || name == ''? Container():InkWell(
                      onTap: (){
                        feedsBloc.translateText(name);
                      },
                      child: Text("See Translation",style: TextStyle(color: Colors.grey),)),
                  const Divider(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: onLikeTap,
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                LineIcons.thumbsUpAlt,
                                color: isLiked ? kUniversalColor : Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            likeCount,
                            style: TextStyle(color:isLiked ? kUniversalColor : Colors.grey),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          InkWell(
                            onTap: (){
                              Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(ref: FirebaseFirestore.instance
                                  .collection('feedPosts').doc(postId).collection('comments'),)));
                            },
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                LineIcons.facebookMessenger,
                                color: Colors.grey,
                              ),
                            ),
                          ),
                          SizedBox(width: 5,),
                          Text(
                            commentCount,
                            style: TextStyle(color: Colors.grey),
                          ),
                        ],
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.grey[200],
                        child: Icon(
                          LineIcons.share,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  },
);
  }
}
