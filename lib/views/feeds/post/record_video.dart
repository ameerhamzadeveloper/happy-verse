import 'dart:async';
import 'dart:io';
import 'dart:math';
import 'dart:ui';
import 'package:line_icons/line_icons.dart';
import 'package:camera/camera.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/feeds/post/video_edit_page.dart';
import 'package:path_provider/path_provider.dart';

class VideoRecordPage extends StatelessWidget {
  const VideoRecordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Row(
          children: [
            IconButton(
              onPressed: (){
                // onNewCameraSelected(cameras![1]);
              },
              icon: Icon(LineIcons.syncIcon),
            )
          ],
        ),
      ),
    );
  }
}


class RecordVideo extends StatefulWidget {
  @override
  _RecordVideoState createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  late CameraController controller;
  List<CameraDescription>? cameras;
  bool cameraInit = false;
  Future<void> initCamera() async {
    availableCameras().then((value) {
      cameras = value;
      controller = CameraController(cameras![0], ResolutionPreset.medium);
      controller.initialize().then((_) {
        if (!mounted) {
          return;
        }
        setState(() {
          cameraInit = true;
        });
      });
    }).catchError((onError) {
      print(onError);
    });
  }
  void onNewCameraSelected(CameraDescription cameraDescription) async {
    if (controller != null) {
      await controller.dispose();
    }
    controller = CameraController(
      cameraDescription,
      ResolutionPreset.high,
      enableAudio: true,
    );

// If the controller is updated then update the UI.
    controller.addListener(() {
      if (mounted) setState(() {});
      if (controller.value.hasError) {
      }
    });

    try {
      await controller.initialize();
    } on CameraException catch (e) {
    }

    if (mounted) {
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    cameraInit = false;
    initCamera();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!cameraInit) {
      return Container(
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [CircularProgressIndicator()],
        ),
      );
    }
    final deviceRatio = getWidth(context) / getHeight(context);
    var camera = controller.value;
    // fetch screen size
    final size = MediaQuery.of(context).size;
    var scale = size.aspectRatio * camera.aspectRatio;

    if (scale < 1) scale = 1 / scale;
    return Scaffold(
      backgroundColor: Colors.black,
      body:SafeArea(
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20.0),
                topRight: Radius.circular(20.0),
                bottomRight: Radius.circular(20.0),
                bottomLeft: Radius.circular(20.0),
              ),
              child: Transform.scale(
                  scale: scale,
                child: Center(
                  child: CameraPreview(controller))),
            ),
            Positioned(
              bottom: 15,
              child: Container(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    RecordButton(
                      controller: controller,
                    )
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.topCenter,
              child:SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      IconButton(
                        onPressed: (){
                          Navigator.pop(context);
                        },
                        icon: const Icon(LineIcons.times,color: Colors.white,size: 30,),
                      ),
                      IconButton(
                        onPressed: (){
                        },
                        icon: const Icon(LineIcons.syncIcon,color: Colors.white,size: 30,),
                      ),
                      IconButton(
                        onPressed: (){
                          onNewCameraSelected(cameras![1]);
                        },
                        icon: const Icon(Icons.flash_on,color: Colors.white,size: 30,),
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class RecordButton extends StatefulWidget {
  final CameraController controller;
  RecordButton({required this.controller});
  @override
  _RecordButtonState createState() => _RecordButtonState();
}

class _RecordButtonState extends State<RecordButton>
    with TickerProviderStateMixin {
  double percentage = 0.0;
  double newPercentage = 0.0;
  double videoTime = 0.0;
  String? videoPath;
  Timer? timer;
  AnimationController? percentageAnimationController;
  @override
  void initState() {
    super.initState();
    setState(() {
      percentage = 0.0;
    });
    percentageAnimationController = new AnimationController(
        vsync: this, duration: new Duration(milliseconds: 1000))
      ..addListener(() {
        setState(() {
          percentage = lerpDouble(
              percentage, newPercentage, percentageAnimationController!.value)!;
        });
      });
  }

  String timestamp() => DateTime.now().millisecondsSinceEpoch.toString();

  void onVideoRecordButtonPressed() {
    startVideoRecording().then((String filePath) {
      if (mounted) setState(() {});
      if (filePath != null) print('Saving video to $filePath');
    });
  }

  Future<String> startVideoRecording() async {
    if (!widget.controller.value.isInitialized) {
      return "";
    }

    final Directory extDir = await getApplicationDocumentsDirectory();
    final String dirPath = '${extDir.path}/Movies/flutter_test';
    await Directory(dirPath).create(recursive: true);
    final String filePath = '$dirPath/${timestamp()}.mp4';

    if (widget.controller.value.isRecordingVideo) {
      // A recording is already started, do nothing.
      return "";
    }

    try {
      setState(() {
        videoPath = filePath;
      });
      await widget.controller.startVideoRecording();
    } on CameraException catch (e) {
      return e.toString();
    }
    return filePath;
  }

  Future<void> stopVideoRecording() async {
    if (!widget.controller.value.isRecordingVideo) {
      return null;
    }

    try {
      await widget.controller.stopVideoRecording();
    } on CameraException catch (e) {
      return null;
    }
  }

  void playVideo() {
    print("pathhh  ===== $videoPath");
   // nextScreen(context, VideoEditPage(
   //   path: videoPath!,
   // ),);
  }

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:  Container(
        height: 120.0,
        width: 120.0,
        child:  CustomPaint(
          foregroundPainter:  RecordButtonPainter(
              lineColor: Colors.black12,
              completeColor: Color(0xFFee5253),
              completePercent: percentage,
              width: 8.0),
          child:  Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onLongPress: () {
                startVideoRecording();
                timer =  Timer.periodic(
                  Duration(milliseconds: 1),
                      (Timer t) => setState(() {
                    percentage = newPercentage;
                    newPercentage += 1;
                    if (newPercentage > 9390.0) {
                      percentage = 0.0;
                      newPercentage = 0.0;
                      timer!.cancel();
                      stopVideoRecording();
                      playVideo();
                    }
                    percentageAnimationController!.forward(from: 0.0);
                    // print((t.tick / 1000).toStringAsFixed(0));
                  }),
                );
              },
              onLongPressEnd: (e) {
                percentage = 0.0;
                newPercentage = 0.0;
                timer!.cancel();
                stopVideoRecording();
                playVideo();
              },
              child: Container(
                child: Center(
                  child: Icon(LineIcons.video,size: 40,color: Colors.white,)
                ),
                decoration: BoxDecoration(
                  color: Color(0xFFee5253),
                  borderRadius: BorderRadius.circular(50),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class RecordButtonPainter extends CustomPainter {
  Color lineColor;
  Color completeColor;
  double completePercent;
  double width;
  RecordButtonPainter(
      {required this.lineColor,required this.completeColor,required this.completePercent,required this.width});
  @override
  void paint(Canvas canvas, Size size) {
    Paint line = new Paint()
      ..color = lineColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Paint complete = new Paint()
      ..color = completeColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = width;
    Offset center = new Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 2, size.height / 2);
    canvas.drawCircle(center, radius, line);
    double arcAngle = 2 * pi * (completePercent / 9390);
    canvas.drawArc(new Rect.fromCircle(center: center, radius: radius), -pi / 2,
        arcAngle, false, complete);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}