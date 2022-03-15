import 'dart:io';

import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/feeds/feeds_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

class VoiceToTextPage extends StatefulWidget {
  const VoiceToTextPage({Key? key}) : super(key: key);

  @override
  _VoiceToTextPageState createState() => _VoiceToTextPageState();
}

class _VoiceToTextPageState extends State<VoiceToTextPage> {
  SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _lastWords = '';

  @override
  void initState() {
    super.initState();
    _initSpeech();
    _startListening();
  }
  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    await _speechToText.listen(onResult: _onSpeechResult);
    setState(() {});
  }

  void _stopListening() async {
    await _speechToText.stop();
    context.read<FeedsCubit>().assignSearchText(_lastWords);
    final auth = context.read<RegisterCubit>();
    context.read<FeedsCubit>().searchUser(auth.userID!, auth.accesToken!);
    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _lastWords = result.recognizedWords;
    });
    print("sdf");
    print(result.finalResult);
    if(result.finalResult){
      context.read<FeedsCubit>().assignSearchText(_lastWords);
      final auth = context.read<RegisterCubit>();
      context.read<FeedsCubit>().searchUser(auth.userID!, auth.accesToken!);
      Navigator.pop(context);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.arrow_back_ios),
                      onPressed: ()=>Navigator.pop(context),
                    ),
                  ],
                ),
                Expanded(
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Text(
                      // If listening is active show the recognized words
                      _speechToText.isListening
                          ? '$_lastWords'
                      // If listening isn't active but could be tell the user
                      // how to start it, otherwise indicate that speech
                      // recognition is not yet ready or not supported on
                      // the target device
                          : _speechEnabled
                          ? 'Tap the microphone to start listening...'
                          : 'Speech not available',
                      style: TextStyle(fontSize: 22),
                    ),
                  ),
                ),
                _speechToText.isNotListening ? InkWell(
                  onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                  child: Material(     // Replace this child with your own
                    elevation: 8.0,
                    shape: const CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                      child: Icon(Icons.mic),
                      radius: 30.0,
                    ),
                  ),
                ):AvatarGlow(
                  endRadius: 100.0,
                  repeat: true,
                  animate: true,
                  showTwoGlows: true,
                  glowColor: kUniversalColor,
                  child: InkWell(
                    onTap: _speechToText.isNotListening ? _startListening : _stopListening,
                    child: Material(     // Replace this child with your own
                      elevation: 8.0,
                      shape: const CircleBorder(),
                      child: CircleAvatar(
                        backgroundColor: Colors.grey[100],
                        child: Icon(Icons.mic),
                        radius: 30.0,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 40,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
