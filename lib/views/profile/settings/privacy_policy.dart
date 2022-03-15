import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';

import '../../components/universal_card.dart';
class PrivacyPolicyPage extends StatefulWidget {
  const PrivacyPolicyPage({Key? key}) : super(key: key);

  @override
  _PrivacyPolicyPageState createState() => _PrivacyPolicyPageState();
}

class _PrivacyPolicyPageState extends State<PrivacyPolicyPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'PRIVACY_POLICY')!),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Container(
              width: getWidth(context),
            ),
            Text("This Page Comming Soon")
          ],
        ),
      ),
    );
  }
}
