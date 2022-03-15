import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  _SplashPageState createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    final bloc = context.read<RegisterCubit>();
    bloc.initPlatformState();
    bloc.getFCM();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kUniversalColor,
      body: Center(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.center,
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
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    MaterialButton(
                      minWidth: 150,
                      color: Colors.white,
                      child: Text(
                        "Create Account",
                        style: Theme.of(context).textTheme.bodyText1,
                      ),
                      shape: const StadiumBorder(),
                      onPressed: () => Navigator.pushNamed(context, signUp),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Already have an account?",
                          style: TextStyle(color: Colors.white),
                        ),
                        TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.white,
                            ),
                            onPressed: () =>
                                Navigator.pushNamed(context, signin),
                            child: const Text("Sign in"))
                      ],
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
