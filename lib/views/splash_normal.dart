import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';

import '../logic/register/register_cubit.dart';
import '../routes/routes_names.dart';
class SplashNormalPage extends StatefulWidget {
  @override
  _SplashNormalPageState createState() => _SplashNormalPageState();
}

class _SplashNormalPageState extends State<SplashNormalPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<RegisterCubit>();
    bloc.getLocation();
    bloc.intiShared();
    Future.delayed(const Duration(seconds: 2),(){
      bloc.getFromShared();
      // Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
      if(bloc.userID != null){
        print("user id is not null");
        Navigator.pushNamedAndRemoveUntil(context, nav, (route) => false);
      }else{
        Navigator.pushNamedAndRemoveUntil(context, splash, (route) => false);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUniversalColor,
      body: Stack(
        children: [
          Align(
            alignment: const Alignment(0.0, 0.0),
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Image.asset(
                AssetConfig.kLogo,
                fit: BoxFit.fill,
                width: MediaQuery.of(context).size.width - 100,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: CupertinoActivityIndicator(
                color: Colors.white,
                radius: 15,
              )
            ),
          ),
        ],
      ),
    );
  }
}
