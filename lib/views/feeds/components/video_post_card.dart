import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/data/model/post_drop_down.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/views/feeds/other_profile/other_profile_page.dart';
import 'package:hapiverse/views/feeds/play_video.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

import '../../../logic/profile/profile_cubit.dart';
import '../../../logic/register/register_cubit.dart';
import '../../../routes/routes_names.dart';
import '../../../utils/constants.dart';
import '../comments_page.dart';
class VideoPostCard extends StatelessWidget {
  String name;
  String iamge;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  String? videothumb;
  String userId;
  final VoidCallback? onLikeTap;
  final VoidCallback? commentOntap;
  int index;
  final bool isLiked;
  VideoPostCard({required this.name,required this.iamge,
    required this.date,required this.commentCount,
    required this.likeCount,required this.profileName,
    required this.profilePic,required this.postId,
    this.onLikeTap,this.commentOntap,this.videothumb,required this.userId,required this.index,required this.isLiked});
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    var color = Colors.grey[300];
    final bloc = context.read<FeedsCubit>();
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<FeedsCubit,FeedsState>(
      builder: (context,state) {
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
                        onTap:(){
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
                       onPressed: (){
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
                     }, icon: Icon(Icons.keyboard_arrow_down_outlined,color: Colors.black,),)
                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                InkWell(
                  onTap: (){
                    nextScreen(context, PlayVideo(
                      url: iamge,
                      profileName: profileName,
                      profileImage: profilePic,
                      time: "${dF.format(date)} at ${tF.format(date)}",
                      caption: name,
                      ref: postId,
                      index :index,
                    ));
                  },
                  child: Container(
                    height: getHeight(context) / 3,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(videothumb!)
                      )
                    ),
                    child: Center(
                      child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(100)
                          ),
                          child: Icon(Icons.play_arrow,size: 50,color: kUniversalColor,)),
                    ),
                  ),
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
                          bloc.translateText(name);
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
      }
    );
  }
}
