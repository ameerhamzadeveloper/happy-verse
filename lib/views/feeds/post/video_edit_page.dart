import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:line_icons/line_icons.dart';
import 'package:video_player/video_player.dart';
import 'package:video_trimmer/video_trimmer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
class VideoEditPage extends StatefulWidget {
  final String path;

  const VideoEditPage({Key? key,required this.path}) : super(key: key);

  @override
  _VideoEditPageState createState() => _VideoEditPageState();
}

class _VideoEditPageState extends State<VideoEditPage> {
  final Trimmer _trimmer = Trimmer();

  double _startValue = 0.0;
  double _endValue = 0.0;

  bool _isPlaying = false;
  bool _progressVisibility = false;

  Future<String> _saveVideo() async {
    setState(() {
      _progressVisibility = true;
    });

    String _value = '';

    await _trimmer
        .saveTrimmedVideo(startValue: _startValue, endValue: _endValue,onSave: (v){})
        .then((value) {
      setState(() {
        _progressVisibility = false;
        // _value = value;
      });
    });

    return _value;
  }


  List<Color> filterList = [
    Colors.pinkAccent,
    Colors.blueAccent,
    Colors.brown,
    Colors.red,
  ];
  late VideoPlayerController controller;
  void _loadVideo() {
    _trimmer.loadVideo(videoFile: File(widget.path));
  }
  @override
  void initState() {
    super.initState();
    controller = VideoPlayerController.file(File(widget.path))..initialize();
    _loadVideo();
  }
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<PostCubit>(context);
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: controller.value.aspectRatio,
                child: VideoPlayer(controller),
              ),
            ),
            PageView.builder(
              itemCount: filterList.length,
              itemBuilder: (context,i) {
                return InkWell(
                  onTap: (){
                    if(controller.value.isPlaying){
                      controller.pause();
                    }else{
                      controller.play();
                    }
                  },
                  child: Center(
                    child: AspectRatio(
                      aspectRatio: controller.value.aspectRatio,
                      child: Container(
                        // width: getWidth(context),
                        // height: getHeight(context),
                        decoration: BoxDecoration(
                            color: filterList[i].withOpacity(0.3),
                            // border: Border.all(color: Colors.white),

                        ),
                      ),
                    ),
                  ),
                );
              }
            ),
            Align(
              alignment: Alignment.topCenter,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed:(){
                      setState(() {
                        if(controller.value.volume == 0){
                          controller.setVolume(0.8);
                        }else{
                          controller.setVolume(0);
                        }
                      });
                    },
                    icon: Icon(controller.value.volume == 0.0 ? LineIcons.volumeUp : LineIcons.volumeOff,color: Colors.white,),
                  ),
                  MaterialButton(
                    onPressed: (){
                      _saveVideo().then((outputPath) {
                        bloc.assingVideoPath(outputPath);
                        print('OUTPUT PATH: $outputPath');
                        Navigator.pop(context);
                        // final snackBar = SnackBar(
                        //     content: Text('Video Saved successfully'));
                        // ScaffoldMessenger.of(context).showSnackBar(
                        //   snackBar,
                        // );
                      });
                    },
                    child: Text("Done",style: TextStyle(color: Colors.white),),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: TrimEditor(
                  trimmer: _trimmer,
                  viewerHeight: 50.0,
                  viewerWidth: MediaQuery.of(context).size.width,
                  maxVideoLength: Duration(seconds: 10),
                  onChangeStart: (value) {
                    setState(() {
                      _startValue = value;
                    });
                  },
                  onChangeEnd: (value) {
                    setState(() {
                      _endValue = value;
                    });
                  },
                  onChangePlaybackState: (value) {
                    setState(() {
                      _isPlaying = value;
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
