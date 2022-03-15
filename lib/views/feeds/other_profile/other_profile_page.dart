import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/views/components/profile_Images_widget.dart';
import 'package:hapiverse/views/components/profile_about_widget.dart';
import 'package:hapiverse/views/components/profile_data_Widget.dart';
import 'package:hapiverse/views/components/profile_friends_list.dart';

import '../../../utils/constants.dart';
import '../../../utils/utils.dart';
import '../../components/universal_card.dart';
class OtherProfilePage extends StatefulWidget {
  final String userId;
  const OtherProfilePage({Key? key,required this.userId}) : super(key: key);

  @override
  _OtherProfilePageState createState() => _OtherProfilePageState();
}

class _OtherProfilePageState extends State<OtherProfilePage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        if(state.otherProfileInfoResponse == null){
          return Scaffold(
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: UniversalCard(
                        widget: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(width: getWidth(context),),
                              CircleAvatar(
                                radius: 35,
                                backgroundColor: Colors.grey[200],
                              ),
                              SizedBox(height: 10,),
                              Container(
                                height: 20,
                                width: 150,
                                color: Colors.grey[200],
                              ),
                              SizedBox(height: 5,),
                              Container(
                                height: 10,
                                width: 100,
                                color: Colors.grey[200],
                              )
                            ],
                          ),
                        )),
                  ),
                ],
              ),
            ),
          );
        }else{
          var json = jsonDecode(state.otherProfileInfoResponse!.body);
          var d = json['data'];
          print(d);
          print(d);
          return Scaffold(
            appBar: AppBar(
              leading: const BackButton(color: Colors.black,),
              backgroundColor: Colors.white,
              // title: const Text("Alisha Luice",style: TextStyle(color: Colors.black),),
            ),
            body: SafeArea(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  Expanded(
                    child: Card(
                        shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                topRight: Radius.circular(20)
                            )
                        ),
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              ProfileDataWidet(isMyProfile: false,data: {
                                'name':d['userName'],
                                'hobbi':"football",
                                'profile_url':"${Utils.baseImageUrl}${d['profileImageUrl']}",
                                'follower': d['follower'],
                                'following':d['following'],
                                'post': '0',
                                'IsFriend': d['IsFriend']
                              },userId: d['userId'],),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ProfileAboutInfo(isMyProfie: false,data:{
                                      'country':d['country'],
                                      'dobFormat': d['DOB'],
                                      'replationship':d['martialStatus'],
                                    },userId: d['userId'],),
                                    ProfileFriendsList(),
                                    ProfileImagesWidget(isMyProfile: false,)
                                  ],
                                ),
                              )
                            ],
                          ),
                        )
                    ),
                  )
                ],
              ),
            ),
          );
        }

      }
    );
  }
}
