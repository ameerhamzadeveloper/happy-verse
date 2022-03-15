import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/logic/story/story_cubit.dart';
class DesignStory extends StatefulWidget {
  const DesignStory({Key? key}) : super(key: key);
  @override
  _DesignStoryState createState() => _DesignStoryState();
}
class _DesignStoryState extends State<DesignStory> {

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<StoryCubit,StoryState>(
      builder: (context,state) {
        return Scaffold(
          body: PageView.builder(
            onPageChanged: (v){
              bloc.assignColor(v);
            },
            itemCount: 5,
            itemBuilder: (ctx,i){
              return Container(
                color: state.pageColor[i],
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: AutoSizeTextField(
                        maxLines: null,
                          // openEmoji()
                        onTap: ()=>bloc.getTimeDiff(),
                        controller: state.message,
                        style: state.textStyle1,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          hintStyle: state.textStyle,
                          hintText: "Type a Status",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topLeft,
                      child: SafeArea(
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  IconButton(onPressed: (){FocusScope.of(context).unfocus();bloc.openEmoji();}, icon: Icon(Icons.emoji_emotions,color: Colors.white,),),
                                  const SizedBox(width: 20,),
                                  IconButton(onPressed: (){bloc.getFonst();}, icon: Icon(Icons.text_format,color: Colors.white,),)
                                ],
                              ),
                              Row(
                                children: [
                                  InkWell(
                                    onTap: (){
                                      bloc.postStory(authB.userID!,authB.accesToken!);
                                      Navigator.pop(context);
                                    },
                                    child: CircleAvatar(
                                      child: Icon(Icons.check),
                                    ),
                                  )
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Offstage(
                        offstage: state.isEmojiOpen,
                        child: SizedBox(
                          height: 250,
                          child: EmojiPicker(
                              onEmojiSelected: (Category category, Emoji emoji) {
                                bloc.onEmojiSelected(emoji);
                              },
                              onBackspacePressed: bloc.onBackspacePressed,
                              config: Config(
                                  columns: 7,
                                  // Issue: https://github.com/flutter/flutter/issues/28894
                                  emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                                  verticalSpacing: 0,
                                  horizontalSpacing: 0,
                                  initCategory: Category.RECENT,
                                  bgColor: const Color(0xFFF2F2F2),
                                  indicatorColor: Colors.blue,
                                  iconColor: Colors.grey,
                                  iconColorSelected: Colors.blue,
                                  progressIndicatorColor: Colors.blue,
                                  backspaceColor: Colors.blue,
                                  showRecentsTab: true,
                                  recentsLimit: 28,
                                  noRecentsText: 'No Recents',
                                  noRecentsStyle: const TextStyle(
                                      fontSize: 20, color: Colors.black26),
                                  tabIndicatorAnimDuration: kTabScrollDuration,
                                  categoryIcons: const CategoryIcons(),
                                  buttonMode: ButtonMode.MATERIAL)),
                        ),),
                    ),
                  ],
                ),
              );
            },
          ),
        );
      }
    );
  }
}
