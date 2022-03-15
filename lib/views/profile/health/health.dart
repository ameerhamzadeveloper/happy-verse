import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/secondry_button.dart';
import 'package:hapiverse/views/profile/health/components/add_record_widget.dart';
import 'package:hapiverse/views/profile/health/components/qr_widget.dart';
import 'package:line_icons/line_icons.dart';

class HealthPage extends StatefulWidget {
  const HealthPage({Key? key}) : super(key: key);

  @override
  _HealthPageState createState() => _HealthPageState();
}

class _HealthPageState extends State<HealthPage> {
  bool val = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'MY_SCAN')!),
        actions: [
          CupertinoSwitch(value:val, onChanged: (Val){
            setState(() {
              val = Val;
            });
          })
        ],
      ),
      body: val ? AddRecordsWidget():QRWidget()
    );
  }
}
