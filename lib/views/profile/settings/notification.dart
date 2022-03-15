import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/constants.dart';
import '../../components/universal_card.dart';
class NotificationSetting extends StatefulWidget {
  const NotificationSetting({Key? key}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(getTranslated(context, 'NOTIFICATION')!),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Text(getTranslated(context, 'PUSH_NOTIFICATION')!,style: TextStyle(fontSize: 18),),
            ListTile(
              title: Text(getTranslated(context, 'TURN_OFF_ALL')!),
              trailing: Container(
                height: 5,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (va){},
                ),
              ),
            ),
            ListTile(
              title: Text(getTranslated(context, 'GROUPS')!),
              trailing: Container(
                height: 5,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (va){},
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
