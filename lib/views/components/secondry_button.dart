import 'package:flutter/material.dart';
import '../../utils/constants.dart';
class SecendoryButton extends StatelessWidget {
  const SecendoryButton({Key? key,required this.text,required this.onPressed}) : super(key: key);
  final String text;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      minWidth: double.infinity,
      color: kSecendoryColor,
      onPressed: onPressed,
      child: Text(text,style: const TextStyle(color: Colors.white),),
    );
  }
}
