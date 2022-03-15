import 'package:flutter/material.dart';
import 'package:story_view/controller/story_controller.dart';
import 'package:story_view/utils.dart';
import 'package:story_view/widgets/story_view.dart';
class StoryWidgetPage extends StatefulWidget {
  final List<StoryItem> storyItem;
  final StoryController controller;
  final VoidCallback onFinish;
  final String title;
  final String image;
  final String date;
  const StoryWidgetPage({Key? key,
    required this.storyItem,required this.controller,
    required this.onFinish,required this.date,required this.title,required this.image}) : super(key: key);
  @override
  _StoryWidgetPageState createState() => _StoryWidgetPageState();
}

class _StoryWidgetPageState extends State<StoryWidgetPage> {
  @override
  void dispose() {
    super.dispose();
    // widget.controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        StoryView(
            repeat: false,
            inline: true,
            storyItems: widget.storyItem,
            controller: widget.controller, // pass controller here too
            // should the stories be slid forever
            onStoryShow: (s) {print(s);},
            onComplete: ()=> widget.onFinish,
            onVerticalSwipeComplete: (direction) {
              if (direction == Direction.down) {
                Navigator.pop(context);
              }
            } // To disable vertical swipe gestures, ignore this parameter.
          // Preferrably for inline story view.
        ),
        SafeArea(
          child: Align(
            alignment: Alignment.topLeft,
            child: Container(
              height: 80,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  children: [
                    Column(
                      children: const [
                        CircleAvatar(),
                      ],
                    ),
                    const SizedBox(width: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(widget.title,style: TextStyle(fontWeight: FontWeight.w500,color: Colors.white),),
                        Text(widget.date,style: TextStyle(fontSize: 11,color: Colors.white),)
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.only(left:8.0,right: 8.0),
                    decoration:BoxDecoration(
                      borderRadius: BorderRadius.circular(10) ,
                      color:Colors.white,
                    ),
                    width: MediaQuery.of(context).size.width - 100,
                    child: Expanded(child: TextField(
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintText: "Type Something",
                          suffixIcon: Icon(Icons.send)
                      ),
                    )),
                  ),
                  IconButton(onPressed: (){}, icon: Icon(Icons.favorite,color: Colors.red,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.star,color: Colors.orangeAccent,)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.emoji_emotions_sharp,color: Colors.blue,)),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
