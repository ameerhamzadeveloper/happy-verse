import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';

import '../../logic/register/register_cubit.dart';
import '../../routes/routes_names.dart';
import '../../utils/constants.dart';

class PlayVideo extends StatefulWidget {
  final String url;
  final String profileName;
  final String profileImage;
  final String time;
  final String caption;
  final String ref;
  final int index;

  const PlayVideo(
      {Key? key,
      required this.url,
      required this.profileName,
      required this.profileImage,
      required this.time,
      required this.caption,
      required this.ref,
      required this.index})
      : super(key: key);

  @override
  _PlayVideoState createState() => _PlayVideoState();
}

class _PlayVideoState extends State<PlayVideo> {
  late VideoPlayerController controller;
  late Duration total = Duration();
  late Duration progress = Duration();
  bool isLoading = true;

  bool isProgressOpen = true;
  progressOpenClose(){
    if(isProgressOpen == true){
      Future.delayed(Duration(seconds: 3),(){
        setState(() {
          isProgressOpen = false;
        });
      });
    }else{
      setState(() {
        isProgressOpen = true;
      });
    }
  }


  setValues() async {}

  @override
  void initState() {
    super.initState();
    print("Video Url ${widget.url}");
    controller = VideoPlayerController.network(widget.url)
      ..initialize().then((value) {
        setState(() {
          isLoading = false;
        });
        controller.play();
        progressOpenClose();
        total = controller.value.duration;
        controller.position.asStream().listen((event) {
          setState(() {
            progress = event!;
            print(event);
          });
          controller.addListener(() {
            setState(() {
              progress = controller.value.position;
            });
            print("Pause");
          });
        });
      });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController message = TextEditingController();
    final authB = context.read<RegisterCubit>();
    final feedsB = context.read<FeedsCubit>();
    return BlocBuilder<FeedsCubit, FeedsState>(
  builder: (context, state) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                            onTap: () => Navigator.pop(context),
                            child: Icon(Icons.arrow_back_ios)),
                        InkWell(
                          onTap: () =>
                              Navigator.pushNamed(context, otherProfile),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundImage:
                                    NetworkImage(widget.profileImage),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.profileName,
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  ),
                                  Text(
                                    widget.time,
                                    style: TextStyle(color: kSecendoryColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(Icons.keyboard_arrow_down_outlined))
                  ],
                ),
              ),
              Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(widget.caption),
              ),
              AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: Stack(
                  children: [
                    InkWell(
                        onTap: () {
                          progressOpenClose();
                          if(controller.value.isPlaying){
                            controller.pause();
                          }else{
                            controller.play();
                          }
                        },
                        child: VideoPlayer(controller)),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: isProgressOpen ? Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: ProgressBar(
                          progress: progress,
                          total: total,
                          onSeek: (duration) {
                            print('User selected a new time: $duration');
                            controller.seekTo(duration);
                          },
                        ),
                      ) :Container(),
                    ),
                    isLoading
                        ? Align(
                            alignment: Alignment.center,
                            child: CircularProgressIndicator(),
                          )
                        : Align(
                            alignment: Alignment.center,
                            child: controller.value.isPlaying
                                ? Container()
                                : IconButton(
                                    onPressed: () => controller.play(),
                                    icon: const Icon(
                                      Icons.play_arrow,
                                      size: 40,
                                      color: kUniversalColor,
                                    ),
                                  ),
                          )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        InkWell(
                          onTap: () {
                            feedsB.addLikeDislike(authB.userID!, authB.accesToken!, state.feedsPost![widget.index].postId!, widget.index);
                          },
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              LineIcons.thumbsUpAlt,
                              color: state.feedsPost![widget.index].isLiked! ? kUniversalColor : Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          state.feedsPost![widget.index].totalLike!,
                          style: TextStyle(color:state.feedsPost![widget.index].isLiked! ? kUniversalColor : Colors.grey),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {},
                          child: CircleAvatar(
                            backgroundColor: Colors.grey[200],
                            child: Icon(
                              LineIcons.facebookMessenger,
                              color: Colors.grey,
                            ),
                          ),
                        ),
                        Text(
                          '0',
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("Comments"),
              ),
              Divider(),
              StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection('feedPosts')
                    .doc(widget.ref)
                    .collection('comments')
                    .snapshots(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasData) {
                    return ListView(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return ListTile(
                            title: Text(data['name']),
                            subtitle: Text(data['title']),
                            leading: CircleAvatar(
                              backgroundImage:
                                  NetworkImage(data['ProfilePic']),
                            ),
                            trailing: Icon(Icons.more_horiz),
                          );
                        }).toList());
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (snapshot.data!.docs.isEmpty) {
                    return Text("No Comments");
                  }
                  return Text("Something Went Wrong");
                },
              ),
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Column(
              //       // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //
              //         // Spacer(),
              //         Wrap(
              //           children: [
              //             Card(
              //               child: Padding(
              //                 padding: const EdgeInsets.only(left: 8.0),
              //                 child: AutoSizeTextField(
              //                   maxLines: null,
              //                   controller: message,
              //                   onChanged: (val){
              //                     text = val;
              //                   },
              //                   decoration: InputDecoration(
              //                     border: InputBorder.none,
              //                     hintText: 'Write Something',
              //                     suffixIcon: IconButton(
              //                       onPressed: () {
              //                         FirebaseFirestore.instance.collection('users')
              //                             .doc(authB.userID).get()
              //                             .then((value) {
              //                           FirebaseFirestore.instance
              //                               .collection('feedPosts').doc(widget.ref).collection('comments').add({
              //                             'name': value.data()?['name'],
              //                             'ProfilePic': value.data()?['profile_url'],
              //                             'title': text,
              //                             'timeStamp': DateTime.now(),
              //                           });
              //                         });
              //                         message.clear();
              //                       },
              //                       icon: const Icon(
              //                         Icons.send,
              //                         color: kUniversalColor,
              //                       ),
              //                     ),
              //                   ),
              //                 ),
              //               ),
              //             ),
              //           ],
              //         )
              //       ]
              //   ),
              // ),
              Wrap(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: AutoSizeTextField(
                            maxLines: null,
                            controller: message,
                            onChanged: (val) {
                              text = val;
                            },
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Write Something',
                              suffixIcon: IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(authB.userID)
                                      .get()
                                      .then((value) {
                                    FirebaseFirestore.instance
                                        .collection('feedPosts')
                                        .doc(widget.ref)
                                        .collection('comments')
                                        .add({
                                      'name': value.data()?['name'],
                                      'ProfilePic': value.data()?['profile_url'],
                                      'title': text,
                                      'timeStamp': DateTime.now(),
                                    });
                                  });
                                  message.clear();
                                },
                                icon: const Icon(
                                  Icons.send,
                                  color: kUniversalColor,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  },
);
  }
}
