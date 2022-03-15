import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:video_player/video_player.dart';
class PlayVideoPage extends StatefulWidget {
  const PlayVideoPage({Key? key}) : super(key: key);

  @override
  _PlayVideoPageState createState() => _PlayVideoPageState();
}

class _PlayVideoPageState extends State<PlayVideoPage> {

  @override
  void dispose() {
    super.dispose();
    context.read<PostCubit>().disposeVideoController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<PostCubit,PostState>(
      builder: (context,state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Stack(
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
                state.videoController!.value.isPlaying == false?
                Align(
                  alignment: Alignment.center,
                  child: InkWell(
                    onTap: (){
                      state.videoController!.play();
                      print(state.videoController!.value.isPlaying);
                    },
                    child: Icon(Icons.play_arrow,color: Colors.white,size: 70,),
                  ),
                ):Container(),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: ProgressBar(
                      timeLabelTextStyle: TextStyle(color: Colors.white),
                      progress: state.videoProgress!,
                      total: state.videoTotalDuration!,
                      onSeek: (duration) {
                        state.videoController!.seekTo(duration);
                      },
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: IconButton(
                    color: Colors.white,
                    icon: Icon(Icons.arrow_back),
                    onPressed: (){
                      state.videoController!.dispose();
                      Navigator.pop(context);
                    },
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
