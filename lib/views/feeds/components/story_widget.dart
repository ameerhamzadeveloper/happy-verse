import 'package:flutter/material.dart';
import 'package:hapiverse/views/feeds/story/story_view.dart';
import 'package:story_view/story_view.dart';
import '../../../data/model/story_model.dart';
import '../../../utils/constants.dart';

class StoryWidget extends StatelessWidget {
  final String title;
  final String image;
  final int index;
  // ignore: prefer_const_constructors_in_immutables
  StoryWidget({required this.image,
    required this.title,
    required this.index,
    Key? key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
        StoryController controller = StoryController();
        Navigator.push(context, MaterialPageRoute(builder: (context) =>
            StoryViewPage(),
      ),
      );
      },
      child: Column(
        children: [
          Card(
              shape:
                  RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              child: Container(
                padding: const EdgeInsets.all(2),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 3, color: kUniversalColor),
                ),
                child: Container(
                  height: 50,
                  width: 50,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      image: DecorationImage(
                          fit: BoxFit.cover,
                          image: NetworkImage(
                            image,
                          ))),
                ),
              )),
          Text(title,style: TextStyle(fontSize: 10),)
        ],
      ),
    );
  }
}
