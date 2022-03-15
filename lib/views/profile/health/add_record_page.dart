import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hapiverse/utils/constants.dart';
class AddRecordPage extends StatefulWidget {
  const AddRecordPage({Key? key}) : super(key: key);

  @override
  _AddRecordPageState createState() => _AddRecordPageState();
}

class _AddRecordPageState extends State<AddRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldBgColor,
      appBar: AppBar(
        title: Text("Add Record"),
        leading: IconButton(
          onPressed: ()=>Navigator.pop(context),
          icon: Icon(Icons.arrow_back_ios,color: Colors.white,),
        ),
        actions: [
          TextButton(onPressed: (){}, child: Text("Done"),style: TextButton.styleFrom(
            primary: Colors.white,
          ),)
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0,right: 8.0),
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                      child: Row(
                        children: [
                          Text("Hospital",style: TextStyle(fontFamily: '',fontSize: 18),),
                          Expanded(
                            child: TextField(
                              textAlign: TextAlign.end,
                              decoration: InputDecoration(
                                hintText: "victoria medical",
                                border: InputBorder.none
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                      child: InkWell(
                        onTap: (){
                          DatePicker.showDatePicker(
                            context,
                            showTitleActions: true,
                            minTime: DateTime(1940, 3, 5),
                            onChanged: (date) {},
                            onConfirm: (date) {},
                            currentTime: DateTime.now(),
                          );
                        },
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text("Expire On",style: TextStyle(fontFamily: '',fontSize: 18),),
                            Text("12 March 2022",style: TextStyle(color: Colors.grey),)
                          ],
                        ),
                      ),
                    )
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
