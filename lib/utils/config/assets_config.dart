import 'dart:convert';
import 'package:flutter/material.dart';

class AssetConfig{
  static const String kLogo = "assets/logo.png";
  static const String kSigninVector = "assets/signin.png";
  static const String postBgBase = 'assets/post_backgrounds/';
  static const String useMask = 'assets/use_mask.png';
  static const String avoidClose = 'assets/avoid_close.png';
  static const String washHand = 'assets/clean_hand.png';
  static const String imageLoading = 'assets/image_loading.jpeg';

  static Image imageFromBase64String(
      String base64String,double height,double width,BoxFit fit) {
    return Image.memory(base64Decode(base64String),height: height,width: width,fit: fit,);
  }

}