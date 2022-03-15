import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:line_icons/line_icons.dart';
class PersonalAccount extends StatefulWidget {
  const PersonalAccount({Key? key}) : super(key: key);

  @override
  _PersonalAccountState createState() => _PersonalAccountState();
}

class _PersonalAccountState extends State<PersonalAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'PERSONAL_ACCOUNT')!),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Text(getTranslated(context, 'ACCOUNT_PRIVACY')!,style: TextStyle(fontSize: 18),),
            ListTile(
              title: Text(getTranslated(context, 'PRIVATE_ACCOUNT')!),
              trailing: Container(
                height: 5,
                child: CupertinoSwitch(
                  value: true,
                  onChanged: (va){},
                ),
              ),
              leading: Icon(LineIcons.lock),
            )
          ],
        ),
      ),
    );
  }
}
