import 'package:flutter/material.dart';
class LoadingStoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color? color = Colors.grey[100];
    return Padding(
      padding: const EdgeInsets.only(left:8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: List.generate(5, (index){
            return Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  // decoration: BoxDecoration(
                  //   borderRadius: BorderRadius.circular(15),
                  //   border: Border.all(width: 3, color: Colors.grey[200]),
                  // ),
                  child: Container(
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: color
                    ),
                  ),
                ),
                Container(
                  height: 10,
                  width: 50,
                  color: color,
                )
              ],
            );
          }),
        ),
      ),
    );
  }
}
