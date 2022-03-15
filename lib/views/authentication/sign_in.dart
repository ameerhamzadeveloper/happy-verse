import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:line_icons/line_icons.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    context.read<RegisterCubit>().initPlatformState();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RegisterCubit,RegisterState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: true,
            elevation: 0.0,
            leading: Container(),
            backgroundColor: const Color(0xffEEF1F8),
            title: const Text(
              "Sign In",
              style: TextStyle(color: Colors.black),
            ),
          ),
          body: Center(
            child: Column(
              children: [
                Image.asset(
                  AssetConfig.kSigninVector,
                  height: 200,
                  width: 200,
                ),
                Expanded(
                  child: Container(
                    decoration: kContainerDecoration,
                    padding: const EdgeInsets.all(25),
                    child: SingleChildScrollView(
                      child: Form(
                        key: globalKey,
                        child: Column(
                          children: [
                            Text(state.errorMessage,style: TextStyle(color: Colors.red),),
                            const SizedBox(
                              height: 20,
                            ),
                             TextFormField(
                               onChanged: (val){
                                 context.read<RegisterCubit>().assignEmail(val);
                               },
                              validator: (val){
                                if (val!.isEmpty) {
                                  return "Email is required";
                                } else if (!RegExp(
                                    r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                                    .hasMatch(val)) {
                                  return 'Please enter a valid email Address';
                                } else {
                                  return null;
                                }
                              },
                              decoration: const InputDecoration(
                                  labelText: 'Email Address',
                                  // hintText: "Email Address",
                                  suffixIcon: Icon(LineIcons.envelope)),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                             TextFormField(
                               obscureText: true,
                               validator: (val){
                                 if(val!.isEmpty){
                                   return "Please Enter Password";
                                 }else if(val.length < 6){
                                   return "Password must be 6 characters";
                                 }else{
                                   return null;
                                 }
                               },
                               onChanged: (val){
                                 context.read<RegisterCubit>().assignPassword(val);
                               },
                              cursorColor: kUniversalColor,
                              decoration: const InputDecoration(
                                labelText: "Password",
                                suffixIcon: Icon(LineIcons.lock),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                TextButton(
                                  style: TextButton.styleFrom(
                                    primary: kUniversalColor,
                                  ),
                                  onPressed: () {},
                                  child: const Text("Forgot your password?"),
                                )
                              ],
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            state.loadingState ? const Center(child: CircularProgressIndicator(),)
                                :MaterialButton(
                              minWidth: 140,
                              shape: const StadiumBorder(),
                              onPressed: () {
                                if(globalKey.currentState!.validate()){
                                  context.read<RegisterCubit>().loginUser(context);
                                }
                              },
                              color: kSecendoryColor,
                              child: const Text(
                                "Sign In",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: const [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                                Text("Or"),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Divider(
                                      color: Colors.grey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: const [
                            //     CircleAvatar(
                            //       backgroundColor: Colors.deepOrange,
                            //       child: Icon(
                            //         LineIcons.googleLogo,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     CircleAvatar(
                            //       backgroundColor: Colors.blueAccent,
                            //       child: Icon(
                            //         LineIcons.facebookF,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //     SizedBox(
                            //       width: 10,
                            //     ),
                            //     CircleAvatar(
                            //       backgroundColor: Colors.lightBlueAccent,
                            //       child: Icon(
                            //         LineIcons.twitter,
                            //         color: Colors.white,
                            //       ),
                            //     ),
                            //   ],
                            // ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  "Don't have account?",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                TextButton(
                                    style: TextButton.styleFrom(
                                      primary: kUniversalColor,
                                    ),
                                    onPressed: () =>
                                        Navigator.pushNamed(context, signUp),
                                    child: Text("Sign Up"))
                              ],
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        );
      }
    );
  }
}
