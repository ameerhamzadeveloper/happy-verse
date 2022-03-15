import 'package:flutter/material.dart';
import '../../utils/constants.dart';
class ProfileFriendsList extends StatelessWidget {
  const ProfileFriendsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children:  [
            Text(getTranslated(context, 'FRIENDS')!,style: TextStyle(color: kUniversalColor),),
            InkWell(
                onTap: (){},
                child: Text(getTranslated(context, 'VIEW_ALL')!,style: TextStyle(color: kUniversalColor),)),
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            children: List.generate(10, (index) => Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  CircleAvatar(
                    radius:25,
                    backgroundImage: NetworkImage("https://edyehillus.files.wordpress.com/2020/07/gettyimages_849177432.jpg"),
                  ),
                  SizedBox(height: 5,),
                  Text("Luic $index")
                ],
              ),
            )),
          ),
        ),
      ],
    );
  }
}
