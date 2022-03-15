import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/secondry_button.dart';

import '../../../logic/register/register_cubit.dart';
class CreateGroupPost extends StatefulWidget {

  const CreateGroupPost({Key? key}) : super(key: key);

  @override
  _CreateGroupPostState createState() => _CreateGroupPostState();
}

class _CreateGroupPostState extends State<CreateGroupPost> {
  @override
  GlobalKey<FormState> keye = GlobalKey<FormState>();
  Widget build(BuildContext context) {
    final authBloc = context.read<RegisterCubit>();
    final bloc = context.read<GroupsCubit>();
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white70,
            leading: const BackButton(color: Colors.black,),
            title: const Text("Create Post",style: TextStyle(color: Colors.black),),
            // actions: [
            //   TextButton(
            //     onPressed: (){
            //     },
            //     child: const Text("Share"),
            //   ),
            // ],
          ),
          body: SingleChildScrollView(
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Form(
                  key: keye,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                Column(
                                  children: const [
                                    CircleAvatar(
                                      radius: 25,
                                      backgroundImage: NetworkImage("https://www.timeshighereducation.com/sites/default/files/languages-signpost.jpg"),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10,),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children:  [
                                      Row(
                                        children: const [
                                          Expanded(child: Text("Ameer Hamza",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),)),
                                        ],
                                      ),
                                      const SizedBox(height: 5,),
                                      Row(
                                        children: const [
                                          Text("🌎 Public")
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 20,),
                      TextField(
                        onChanged: (val){
                          bloc.assignCaption(val);
                        },
                        decoration: const InputDecoration(
                          hintText: "Post Caption",
                        ),
                      ),
                      SizedBox(height: 10,),
                      Text("Add Image"),
                      SizedBox(height: 10,),
                      state.groupCover == null ? Container(
                        width: double.infinity,
                        height: getHeight(context) / 4,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.grey[300]
                        ),
                        child: Center(
                          child: InkWell(
                            onTap: ()=> bloc.getImage(),
                            child: Icon(Icons.add,size: 60,),
                          ),
                        ),
                      ):Container(
                        width: double.infinity,
                        height: getHeight(context) / 4,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            // color: Colors.grey[300],
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: FileImage(File(state.groupCover!.path))
                          )
                        ),
                      ),
                      Text(state.error,style: TextStyle(color: Colors.red),),
                      SizedBox(height: 20,),
                      SecendoryButton(text: "Share", onPressed: (){
                        if(state.groupCover != null){
                          bloc.assignisSub();
                          // bloc.addGroupPosts(authBloc.userID!,context);
                        }else{
                          bloc.assignErro("Image is Required");
                        }
                      })
              ],
            ),
                )
        ),
        ),
          )
        );
      }
    );
  }
}
