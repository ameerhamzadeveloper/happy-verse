import 'package:flutter/material.dart';
import '../../../utils/constants.dart';
import '../../components/universal_card.dart';

class DataPolicy extends StatefulWidget {
  const DataPolicy({Key? key}) : super(key: key);
  @override
  _DataPolicyState createState() => _DataPolicyState();
}

class _DataPolicyState extends State<DataPolicy> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:  Text(getTranslated(context, 'DATA_POLICY')!),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Container(
              width: getWidth(context),
            ),
            const Text("This Page Coming Soon")
          ],
        ),
      ),
    );
  }
}