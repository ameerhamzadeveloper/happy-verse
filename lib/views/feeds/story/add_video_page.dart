import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:video_player/video_player.dart';

import '../../../logic/story/story_cubit.dart';
class AddVideoPageStory extends StatefulWidget {
  const AddVideoPageStory({Key? key}) : super(key: key);
  @override
  _AddVideoPageStoryState createState() => _AddVideoPageStoryState();
}

class _AddVideoPageStoryState extends State<AddVideoPageStory> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<StoryCubit,StoryState>(
        builder: (context,state) {
          return Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              title: Text("Add Video"),
              actions: [
                IconButton(onPressed: (){}, icon: Icon(Icons.check))
              ],
            ),
            body: Stack(
              children: [
                Align(
                  alignment: Alignment.center,
                  child: Center(
                      child: AspectRatio(
                        aspectRatio: state.videoController!.value.aspectRatio,
                        child: InkWell(
                            onTap: (){
                              if(state.videoController!.value.isPlaying){
                                state.videoController!.pause();
                              }else{
                                state.videoController!.play();
                              }
                              print(state.videoController!.value.isPlaying);
                            },
                          child: VideoPlayer(state.videoController!)),
                      ),
                  ),
                ),
                state.videoController!.value.isPlaying ?
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      state.videoController!.play();
                      print(state.videoController!.value.isPlaying);
                    },
                    child: Icon(Icons.play_arrow,color: Colors.white,size: 70,),
                  ),
                ):Container()
              ],
            ),
          );
        }
    );
  }
}
