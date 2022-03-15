import 'package:flutter/material.dart';

import '../localization/language_localization.dart';

const Color kUniversalColor = Color(0xff0E0A75);
const Color kSecendoryColor = Color(0xffCAAF66);
const Color kScaffoldBgColor = Color(0xffEEF1F8);
Color kTextGrey = const Color(0xff383838);
const BoxDecoration kContainerDecoration = BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30),
        topRight: Radius.circular(30)
    )
);
void nextScreen(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
}

ShapeBorder cardRadius = const RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
        topRight: Radius.circular(20),
        topLeft: Radius.circular(20)
    )
);

String? getTranslated(BuildContext context, String key) {
    return DemoLocalization.of(context)!.translate(key);
}

double getHeight(context)=>MediaQuery.of(context).size.height;
double getWidth(context)=>MediaQuery.of(context).size.width;

