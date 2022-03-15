import 'package:flutter/material.dart';
class SettingComponents extends StatelessWidget {
  const SettingComponents({Key? key,required this.onTap,required this.title,required this.icon,required this.isEnd}) : super(key: key);
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool isEnd;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(left:8.0,top: 8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      size: 20,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 5,),
                    Text(title,style: TextStyle(fontSize: 16),),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(right:8.0),
                  child: Icon(Icons.arrow_forward_ios,size: 15,color: Colors.grey,),
                )
              ],
            ),
            isEnd ? Container(
              height: 10,
            ):Divider(),
          ],
        ),
      ),
    );
  }
}
