import 'package:flutter/material.dart';

import '../../../utils/constants.dart';
class FriendSuggestionWidget extends StatelessWidget {
  const FriendSuggestionWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: getHeight(context) / 4,
      width: getWidth(context) / 2,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10,),
            Container(
              height: getHeight(context)/ 6.8,
              width: getWidth(context)/2,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: const DecorationImage(
                      fit: BoxFit.cover,
                      image: NetworkImage("https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg")
                  ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                MaterialButton(
                  height: 30,
                  color:kSecendoryColor,
                  shape:const StadiumBorder(),
                  onPressed: (){},
                  child: const Text("Follow",style: TextStyle(color: Colors.white),),
                ),
                Container(
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border.all(color: kSecendoryColor),
                      borderRadius: BorderRadius.circular(10)
                  ),
                  child: MaterialButton(
                    onPressed: (){},
                    child: const Text("Remove",style: TextStyle(color: kSecendoryColor),),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
