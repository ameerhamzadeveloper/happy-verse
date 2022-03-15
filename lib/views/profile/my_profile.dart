import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/components/profile_about_widget.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';

import '../../routes/routes_names.dart';
import '../components/profile_Images_widget.dart';
import '../components/profile_data_Widget.dart';
import '../components/profile_friends_list.dart';

class MyProfile extends StatefulWidget {
  const MyProfile({Key? key}) : super(key: key);

  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(getTranslated(context, 'PROFILE')!),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, health);
                  },
                  icon: const Icon(
                    LineIcons.heartbeat,
                    color: Colors.white,
                  )),
              IconButton(
                onPressed: () => Navigator.pushNamed(context, profileSettings),
                icon: const Icon(
                  LineIcons.cog,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          body: state.profileName == null ? UniversalCard(
              widget: Padding(
                padding: const EdgeInsets.all(8.0),
                child: RefreshIndicator(
                  onRefresh: ()async{
                    return bloc.fetchMyPRofile(authBloc.userID!, authBloc.accesToken!);
                  },
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
                ),
              ))
              :RefreshIndicator(
            onRefresh: ()async{
              return bloc.fetchMyPRofile(authBloc.userID!, authBloc.accesToken!);
            },
                child: Column(
            children: [
                const SizedBox(height: 20,),
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
                  ProfileDataWidet(isMyProfile: true,data: {
                    'name':state.profileName,
                    'hobbi':state.hobby,
                    'profile_url':"${Utils.baseImageUrl}${state.profileImage}",
                    'follower': state.followers,
                    'following':state.following,
                    'post':state.totalPost,
                    'IsFriend':'default',
                  },userId:authBloc.userID!),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ProfileAboutInfo(isMyProfie: true,data: {
                          'country':state.country,
                          'dobFormat': state.dateOfBirth,
                          'replationship':state.relationShip,
                        },userId:authBloc.userID!),
                        ProfileFriendsList(),
                        ProfileImagesWidget(isMyProfile: true,)
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
    );
  }
}
