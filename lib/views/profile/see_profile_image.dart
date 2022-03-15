import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:photo_view/photo_view.dart';
class SeeProfileImage extends StatefulWidget {
  final String imageUrl;
  final String title;

  const SeeProfileImage({Key? key,required this.imageUrl,required this.title}) : super(key: key);

  @override
  _SeeProfileImageState createState() => _SeeProfileImageState();
}

class _SeeProfileImageState extends State<SeeProfileImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text(widget.title),
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            onPressed: (){},
            icon: Icon(LineIcons.download,color: Colors.white,),
          )
        ],
      ),
      backgroundColor: Colors.black,
      body: Center(
        child: PhotoView(imageProvider: NetworkImage(widget.imageUrl),),
      ),
    );
  }
}
