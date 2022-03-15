import 'package:flutter/material.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:line_icons/line_icons.dart';
import '../../../../utils/constants.dart';
class AddRecordsWidget extends StatelessWidget {
  const AddRecordsWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(getTranslated(context, 'ADD_COVID_RECORD')!,style: TextStyle(fontSize: 32,fontWeight: FontWeight.bold,fontFamily: ''),textAlign: TextAlign.center,),
          const SizedBox(height: 10,),
          Text(getTranslated(context, 'UPDATE_YOUR_RECORD')!),
          const SizedBox(height: 20,),
           ListTile(
            leading: Icon(LineIcons.database,color: Colors.blue,size: 30,),
            title: Text(getTranslated(context, 'Save_your_record_into_database')!),
            subtitle: Text("Add record will be save into database can be access anytime anywhere"),
          ),
           ListTile(
            leading: Icon(LineIcons.qrcode,color: Colors.green,size: 30,),
            title: Text(getTranslated(context, 'Generate_QR_code')!),
            subtitle: Text("With current record you can generate QR code can share with others"),
          ),
           ListTile(
            leading: Icon(LineIcons.smilingFace,color: Colors.deepOrange,size: 30,),
            title: Text(getTranslated(context, 'Stay_Safe_Stay_Happy')!),
            subtitle: Text("with us staty happy and stay safe"),
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: MaterialButton(
              height: 40,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
              ),
              minWidth: double.infinity,
              onPressed: ()=> Navigator.pushNamed(context, addRecordPAge),
              color: kSecendoryColor,
              child: Text(getTranslated(context, 'ADD_RECORD')!,style: TextStyle(color: Colors.white,fontSize: 18),),
            ),
          )
          // SecendoryButton(text: "Add Record", onPressed: (){})
        ],
      ),
    );
  }
}
