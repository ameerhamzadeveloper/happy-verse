import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:line_icons/line_icons.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../utils/constants.dart';
import '../../components/universal_card.dart';
class LocationSettings extends StatefulWidget {
  const LocationSettings({Key? key}) : super(key: key);

  @override
  _LocationSettingsState createState() => _LocationSettingsState();
}

class _LocationSettingsState extends State<LocationSettings> {
  bool locationVal = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(getTranslated(context, 'LOCATION_PRIVACY')!),
        ),
      body:  UniversalCard(
        widget: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(getTranslated(context, 'LOCATION_SERVICES')!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("To choose if Hapiverse receives this device's precise location, go to your device settings."),
            SizedBox(height: 10,),
            Text(getTranslated(context, 'ALWAYS')!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We receive this device's precise location even when you aren't using Hapiverse."),
            SizedBox(height: 10,),
            Text(getTranslated(context, 'WHILE_USING')!,style: TextStyle(fontSize: 22,fontWeight: FontWeight.bold),),
            SizedBox(height: 10,),
            Text("We receive this device's precise location only when you use Hapiverse"),
            ListTile(
              title: Text(getTranslated(context, 'TURN_OFF_LOCATION')!),
              trailing: Container(
                height: 5,
                child: CupertinoSwitch(
                  value: locationVal,
                  onChanged: (va)async{
                    Geolocator.openLocationSettings();
                    // Geolocator.openAppSettings();
                    if(await Permission.location.isGranted == true){
                      setState(() {
                        locationVal = true;
                      });
                    }else{
                      setState(() {
                        locationVal = false;
                      });
                    }
                  },
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
