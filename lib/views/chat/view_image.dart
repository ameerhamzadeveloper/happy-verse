import 'package:flutter/material.dart';
class ViewImage extends StatefulWidget {
  final userName;
  final String imageURl;

  ViewImage({required this.userName,required this.imageURl});
  @override
  _ViewImageState createState() => _ViewImageState();
}

class _ViewImageState extends State<ViewImage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Text(widget.userName),
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.more_vert,color: Colors.white,))
        ],
      ),
      body: Hero(
        tag: widget.userName,
        child: Center(
          child: Image.network(widget.imageURl),
        ),
      ),
    );
  }
}
