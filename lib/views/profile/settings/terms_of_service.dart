import 'package:flutter/material.dart';
import 'package:hapiverse/utils/constants.dart';

import '../../components/universal_card.dart';
class TermsOfService extends StatefulWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  _TermsOfServiceState createState() => _TermsOfServiceState();
}

class _TermsOfServiceState extends State<TermsOfService> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'TERMS_OF_SERVICE')!),
      ),
      body:  UniversalCard(
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
