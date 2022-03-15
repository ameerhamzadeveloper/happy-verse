import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';
class ProfileAboutInfo extends StatelessWidget {
  bool isMyProfie;
  Map<String, dynamic> data;
  String userId;

  ProfileAboutInfo({Key? key,required this.isMyProfie,required this.userId,required this.data}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final dF = DateFormat('dd MMM yyyy');
    return Column(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.mapMarker,color: kSecendoryColor,),
                Text(getTranslated(context, 'LIVE_IN')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['country'] ?? "",style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.birthdayCake,color: kSecendoryColor,),
                Text(getTranslated(context, 'BIRTH_DATE')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['dobFormat'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(LineIcons.userFriends,color: kSecendoryColor,),
                Text(getTranslated(context, 'RELATIONSHIP')!)
              ],
            ),
            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.only(left:10.0),
              child: Text(data['replationship'],style: TextStyle(fontSize: 18),),
            ),
            Divider(),
            SizedBox(height: 10,),
          ],
        ),
        isMyProfie ? Row(
          children: [
            const Icon(LineIcons.arrowCircleUp,color: kSecendoryColor,),
            Text(getTranslated(context, 'UPGRAD_MY_PLAN')!)
          ],
        ):Container(),
      ],
    );
  }
}
