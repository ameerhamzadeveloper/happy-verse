import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/views/chat/conservation.dart';
import 'package:hapiverse/views/profile/see_profile_image.dart';
import 'package:intl/intl.dart';

import '../../logic/feeds/feeds_cubit.dart';
import '../../logic/register/register_cubit.dart';
import '../../utils/constants.dart';
class ProfileDataWidet extends StatelessWidget {
  final bool isMyProfile;
  Map<String, dynamic> data;
  String userId;
  ProfileDataWidet({Key? key,required this.userId,required this.isMyProfile,required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool isFollowed = false;
    // String isFriend = data['IsFriend'];
    final feedBloc = context.read<FeedsCubit>();
    final authBloc = context.read<RegisterCubit>();
    final profileBloc = context.read<ProfileCubit>();
    return Container(
      width: getWidth(context),
      height: getHeight(context)/ 5.0,
      child: Stack(
        children: [
          Positioned(
            left: 20,
            top: 20,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: (){
                      nextScreen(context, SeeProfileImage(imageUrl: data['profile_url'],title: data['name'],));
                    },
                    child: CircleAvatar(radius: 35,backgroundImage: NetworkImage(data['profile_url']),)),
                  const SizedBox(height: 15,),
                  Text(data['name'],style: TextStyle(fontSize: 22,fontWeight: FontWeight.w700),),
                  Text(data['hobbi']),
                ],
              ),
            ),
          ),
          Positioned(
            right: isMyProfile ? getWidth(context) / 8:getWidth(context) / 11,
            // top: 20,
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: SizedBox(
                // width: getWidth(context) / 2.2,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: isMyProfile ? CrossAxisAlignment.center:CrossAxisAlignment.center,
                  children: [
                    Container(
                      // width: getWidth(context) / 2.4,
                      child: Row(
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              Text(data['post'].toString(),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text(getTranslated(context, 'POST')!,style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text(NumberFormat.compact().format(int.parse(data['follower'])),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text(getTranslated(context, 'FOLLOWERS')!,style: TextStyle(fontSize: 12),),
                            ],
                          ),
                          SizedBox(width: 20,),
                          Column(
                            children: [
                              Text(NumberFormat.compact().format(int.parse(data['following'])),style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600),),
                              Text(getTranslated(context, 'FOLLOWING')!,style: TextStyle(fontSize: 12),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        isMyProfile ? MaterialButton(
                          height: 25,
                          shape: const StadiumBorder(),
                          color: kSecendoryColor,
                          onPressed: ()=> Navigator.pushNamed(context, editProfile),
                          child: Text(getTranslated(context, 'EDIT_PROFILE')!,style: TextStyle(color: Colors.white),),
                        ):
                        Row(
                          children: [
                            MaterialButton(
                              height: 25,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              // onPressed: (){},
                              onPressed: (){
                                profileBloc.addFollow(userId,authBloc.userID!, authBloc.accesToken!);
                              },
                              child: Text(data['IsFriend'],style: const TextStyle(color: Colors.white),),
                            ),
                            const SizedBox(width: 5,),
                            MaterialButton(
                              height: 25,
                              shape: const StadiumBorder(),
                              color: kSecendoryColor,
                              onPressed: (){
                                nextScreen(context, ConservationPage(profileImage: data['profile_url'], recieverPhone: userId, recieverName: data['name']));
                                // profileBloc.getFriendList(authBloc.userId, authBloc.token);
                              },
                              child: Text("Message",style: TextStyle(color: Colors.white),),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
