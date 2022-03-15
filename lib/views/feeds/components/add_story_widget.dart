import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/story/story_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import '../../../utils/constants.dart';

class AddStoryWidget extends StatelessWidget {
  const AddStoryWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<StoryCubit>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            child: Container(
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                border: Border.all(width: 3, color: kUniversalColor),
              ),
              child: Center(
                child: IconButton(
                  onPressed: () {
                    showModalBottomSheet(
                      context: context,
                      builder: (ctx) {
                        return SizedBox(
                          height: 130,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Icon(Icons.text_format),
                                title: Text("Text"),
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.pushNamed(context, storyDesign);
                                },
                              ),
                              ListTile(
                                leading: Icon(Icons.image),
                                title: Text("Image"),
                                onTap: () async{
                                  await bloc.getImage(context);
                                  Navigator.pushNamed(context, storyImagePage);
                                },
                              ),
                              // ListTile(
                              //     leading: Icon(Icons.video_call_sharp),
                              //     title: Text("Video"),
                              //     onTap: () async{
                              //       await bloc.getVideo(context);
                              //       Navigator.pushNamed(context, storyVideoPage);
                              //     })
                            ],
                          ),
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.add),
                ),
              ),
            ),
          ),
          const Text("Add Story",style: TextStyle(fontSize: 10),)
        ],
      ),
    );
  }
}
