import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/story/story_cubit.dart';

import '../../../logic/register/register_cubit.dart';
class AddImagePageStory extends StatefulWidget {
  const AddImagePageStory({Key? key}) : super(key: key);

  @override
  _AddImagePageStoryState createState() => _AddImagePageStoryState();
}

class _AddImagePageStoryState extends State<AddImagePageStory> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<StoryCubit,StoryState>(
      builder: (context,state) {
        return Scaffold(
          backgroundColor: Colors.black,
          appBar: AppBar(
            title: Text("Add Image"),
            actions: [
              IconButton(onPressed: (){
                bloc.postStory(authB.userID!,authB.accesToken!);
                Navigator.pop(context);
              }, icon: Icon(Icons.check))
            ],
          ),
          body: Center(
            child: Image.file(File(state.storyImage!.path))),
        );
      }
    );
  }
}
