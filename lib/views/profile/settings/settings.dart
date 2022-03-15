import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:hapiverse/views/profile/settings/components/setting_widget.dart';
import 'package:line_icons/line_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
class ProfileSettings extends StatefulWidget {
  const ProfileSettings({Key? key}) : super(key: key);

  @override
  _ProfileSettingsState createState() => _ProfileSettingsState();
}

class _ProfileSettingsState extends State<ProfileSettings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'SETTINGS')!),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left:8.0),
              child: Text(getTranslated(context, 'ACCOUNT')!,style: TextStyle(color: Colors.grey),),
            ),
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, personalAccount), title: getTranslated(context, 'PERSONAL_ACCOUNT')!, icon: LineIcons.user,isEnd: false,),
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, notificationSettings), title: getTranslated(context, 'NOTIFICATION')!, icon: LineIcons.bell,isEnd: false,),
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, languageSelection), title: getTranslated(context, 'LANGUAGE')!, icon: LineIcons.globe,isEnd: false,),
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, locationSettings), title: getTranslated(context, 'LOCATION')!, icon: LineIcons.mapMarked,isEnd: true,),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left:8.0),
              child: Text("Standards Policy",style: TextStyle(color: Colors.grey),),
            ),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Column(
                children: [
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, termsOfService), title: getTranslated(context, 'TERMS_OF_SERVICE')!, icon: LineIcons.book,isEnd: false,),
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, dataPolicy), title: getTranslated(context, 'DATA_POLICY')!, icon: LineIcons.database,isEnd: false,),
                  SettingComponents(onTap: ()=> Navigator.pushNamed(context, privacyPolicy), title: getTranslated(context, 'PRIVACY_POLICY')!, icon: LineIcons.lock,isEnd: true,),
                ],
              ),
            ),
            Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              child: SettingComponents(onTap: (){
                print("sdfds");
                showDialog(
                    context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Column(
                            children: <Widget>[
                              Text(getTranslated(context, 'ARE_U_SURE_YOU_WANT_TO_LOGOUT?')!),
                            ],
                          ),
                          actions: <Widget>[
                            CupertinoDialogAction(
                              child: Text(getTranslated(context, 'YES')!),
                              onPressed: () async{
                                SharedPreferences pre = await SharedPreferences.getInstance();
                                        pre.clear();
                                        Navigator.pushNamedAndRemoveUntil(context, splashNormal, (route) => false);
                              },),
                            CupertinoDialogAction(
                              child: Text(getTranslated(context, 'NO')!),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },),
                          ],
                        );
                      }
                    );

              }, title: getTranslated(context, 'LOGOUT')!, icon: LineIcons.alternateSignOut,isEnd: true,)),
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Image.asset(AssetConfig.kLogo,height: 30,width: 30,),
                        SizedBox(width: 10,),
                        Text("Hapiverse"),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Text("Hapiverse${getTranslated(context, 'ABOUT')!}"),
                    Text(getTranslated(context, 'HAPIVERSE_IS_A_UNIVERSAL')!,style: TextStyle(fontSize: 12,color: Colors.grey),)
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
