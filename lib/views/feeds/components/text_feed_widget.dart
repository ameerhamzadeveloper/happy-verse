import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/views/feeds/other_profile/other_profile_page.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
import '../comments_page.dart';
class TextFeedsWidget extends StatelessWidget {
  String name;
  String likeCount;
  String commentCount;
  String profileName;
  DateTime date;
  String profilePic;
  String postId;
  final VoidCallback? onTap;
  final VoidCallback? commentOntap;
  String bgImage;
  String userId;

  TextFeedsWidget({Key? key,required this.date,required this.commentOntap,
  required this.onTap,required this.likeCount,required this.postId,required this.name,
  required this.profileName,required this.commentCount,required this.profilePic,
required this.bgImage,required this.userId}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    final profileBloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
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
                      onPressed: () {

                      },
                      icon: Icon(Icons.keyboard_arrow_down_outlined))
                ],
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: getHeight(context) / 4,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      fit:BoxFit.fill,
                      image: AssetImage(
                        bgImage
                      )
                  )
              ),
              child: Center(child: Text(name)),
            ),
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          InkWell(
                            onTap: (){},
                            child: CircleAvatar(
                              backgroundColor: Colors.grey[200],
                              child: Icon(
                                LineIcons.thumbsUpAlt,
                                color: kUniversalColor,
                              ),
                            ),
                          ),
                          Text(
                            likeCount,
                            style: TextStyle(color: kUniversalColor),
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
}
