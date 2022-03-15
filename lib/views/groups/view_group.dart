import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/feeds/comments_page.dart';
import 'package:hapiverse/views/groups/post/create_post.dart';
import 'package:hapiverse/views/groups/settings.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
import '../feeds/components/friends_suggestion_widget.dart';
import '../feeds/components/post_widget.dart';
import '../feeds/post/add_post.dart';

class ViewGroups extends StatefulWidget {
  final int index;

  const ViewGroups({Key? key, required this.index}) : super(key: key);

  @override
  _ViewGroupsState createState() => _ViewGroupsState();
}

class _ViewGroupsState extends State<ViewGroups> {
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    final tF = DateFormat('hh:mm a');
    final bloc = context.read<GroupsCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context,state) {
        return Scaffold(
          body: CustomScrollView(
            slivers: <Widget>[
              //2
              SliverAppBar(
                actions: [
                  IconButton(onPressed: () {
                    nextScreen(context, GroupSettings(id: widget.index.toString(),));
                  }, icon: Icon(LineIcons.cog))
                ],
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 250.0,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: false,
                  title: Text(state.groups![widget.index].groupName),
                  background: Image.network(
                    "${Utils.baseImageUrl}${state.groups![widget.index].groupImageUrl}",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text("Privacy Type : ${state.groups![widget.index].groupPrivacy}"),
                ),
              ),
              // SliverList(
              //     delegate: SliverChildListDelegate([
              //       StreamBuilder(
              //         stream: FirebaseFirestore.instance
              //             .collection('groupPosts').where('PostId',isEqualTo: widget.id)
              //             .snapshots(),
              //         builder: (context,AsyncSnapshot<QuerySnapshot> snapshot) {
              //           if (snapshot.hasData) {
              //             return ListView(
              //               physics: NeverScrollableScrollPhysics(),
              //               shrinkWrap: true,
              //               children: snapshot.data!.docs.map((DocumentSnapshot document){
              //                 Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
              //                 return InkWell(
              //                   onTap: (){
              //                     // Navigator.pushNamed(context, viewGroups);
              //                     // Navigator.push(context, MaterialPageRoute(builder: (context) => ViewGroups(id: document.id)));
              //                   },
              //                   child: Padding(
              //                       padding: const EdgeInsets.only(bottom: 8.0),
              //                       child: PostWidget(
              //                         commentOntap: (){
              //                           Navigator.push(context, MaterialPageRoute(builder: (context) => CommentPage(ref: FirebaseFirestore.instance
              //                               .collection('groupPosts').doc(document.id).collection('comments'),)));
              //                         },
              //                         onTap:(){
              //                           var ref = FirebaseFirestore.instance
              //                               .collection('groupPosts').doc(document.id);
              //                           FirebaseFirestore.instance
              //                               .collection('groupPosts').doc(document.id).collection('liked').doc(authB.userID).get().then((value){
              //                             if(value.exists){
              //                               FirebaseFirestore.instance
              //                                   .collection('groupPosts').doc(document.id).collection('liked').doc(authB.userID).delete();
              //                               print("Exist");
              //                               ref.update({
              //                                 'like':data['like']-1
              //                               });
              //                             }else{
              //                               FirebaseFirestore.instance
              //                                   .collection('groupPosts').doc(document.id).collection('liked').doc(authB.userID).set({
              //                                 'id' : authB.userID
              //                               });
              //                               print("Not Exist");
              //                               ref.update({
              //                                 'like':data['like']++
              //                               });
              //                             }
              //                           });
              //                         },
              //                         collid: document.id,
              //                         name: data['title'],
              //                         iamge: data['image_url'],
              //                         date: "${dF.format(data['timestamp'].toDate())} at ${tF.format(data['timestamp'].toDate())}",
              //                         commentCount: data['comments'].toString(),
              //                         likeCount: data['like'].toString(),
              //                         profileName: data['profileName'],
              //                         profilePic: data['profileImage'],
              //                       )
              //                   ),
              //                 );
              //               }).toList(),
              //             );
              //           } else if (snapshot.connectionState ==
              //               ConnectionState.waiting) {
              //             return Center(
              //               child: CircularProgressIndicator(),
              //             );
              //           }
              //           return Text("Something Went Wrong");
              //         },
              //       )
              //     ]))

              // SliverAnimatedList(
              //   itemBuilder: (ctx, i, animation) {
              //     return SizeTransition(
              //       sizeFactor: animation,
              //       child: PostWidget(
              //       name: "Ameer Hamza",
              //       iamge: "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRv2YoRcjxyetvhEjmPWDbdfulWMP6y30_ihOmmHdUgcVo_eJVNUQaBhrvp4owuAFuBzqw&usqp=CAU",
              //       date: "12 Dec 2022 at 12:47 AM",
              //       commentCount: '18',
              //       likeCount: '12k',
              //       profileName: "John Doe",
              //       profilePic: "https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg",
              //     )
              //     );
              //   },
              //   initialItemCount: 3,
              // )
            ],
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () {
              print(state.groups![widget.index].groupId,);
              // bloc.assignGroupId(widget.id);
              nextScreen(context, AddPostPage(isFromGroup: true,groupId: state.groups![widget.index].groupId,));
            },
          ),
        );
      }
    );
  }

  Widget postWidget() {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: 5,
      itemBuilder: (ctx, i) {
        if (i == 1) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text("Peoples you may know"),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(4, (index) {
                        return const FriendSuggestionWidget();
                      }),
                    ),
                  ),
                ],
              ),
            ),
          );
        } else {
          return PostWidget(
            postId: 'd',
            userId: "2",
            name: "Ameer Hamza",
            iamge:[],
            date: DateTime.now(),
            commentCount: '18',
            likeCount: '12k',
            profileName: "John Doe",
            profilePic:
                "https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg",
            isLiked: false,
            index: 0,
          );
        }
      },
    );
  }
}
