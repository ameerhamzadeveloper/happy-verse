import 'dart:io';
import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:hapiverse/logic/post_cubit/post_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/authentication/scale_navigation.dart';
import 'package:hapiverse/views/feeds/post/record_video.dart';
import 'package:hapiverse/views/feeds/post/video_edit_page.dart';
import 'package:image_size_getter/file_input.dart';
import 'package:image_size_getter/image_size_getter.dart';
import 'package:line_icons/line_icons.dart';
import 'add_places.dart';

class AddPostPage extends StatefulWidget {
  final bool isFromGroup;
  final String? groupId;
  const AddPostPage({Key? key,required this.isFromGroup,this.groupId}) : super(key: key);
  @override
  _AddPostPageState createState() => _AddPostPageState();
}
class _AddPostPageState extends State<AddPostPage> {

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<PostCubit>();
    final authB = context.read<RegisterCubit>();
    return BlocBuilder<PostCubit,PostState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            elevation: 0.0,
            backgroundColor: Colors.white70,
            leading: const BackButton(color: Colors.black,),
            title: Text(getTranslated(context, 'CREATE_POST')!,style: TextStyle(color: Colors.black),),
            actions: [
              TextButton(
                onPressed: (){
                  if(widget.isFromGroup){
                    bloc.createGroupPost(authB.userId,authB.accesToken!,widget.groupId!);
                    Navigator.pop(context);
                  }else{
                    bloc.createPost(authB.userId,authB.accesToken!);
                    Navigator.pop(context);
                  }

                },
                child: Text(getTranslated(context, 'SHARE')!),
              ),
            ],
          ),
          body: Stack(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            BlocBuilder<ProfileCubit,ProfileState>(
                              builder: (context,stateP) {
                                return Expanded(
                                  child: Row(
                                    children: [
                                      Column(
                                        children:  [
                                          CircleAvatar(
                                            radius: 25,
                                            backgroundImage: NetworkImage("${Utils.baseImageUrl}${stateP.profileImage}"),
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
                                               children: [
                                                 Expanded(child: Text("${stateP.profileName} ${state.currentPlace != null ? " - ${state.currentPlace}":""}",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black),)),
                                               ],
                                             ),
                                            const SizedBox(height: 5,),
                                            Container(
                                              height: 25,
                                              padding: const EdgeInsets.only(left: 5,right: 5),
                                              decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(8),
                                                  border: Border.all(width: 0.3)
                                              ),
                                              child: DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  items: state.dropList.map((String value) {
                                                    return DropdownMenuItem<String>(
                                                      value: value,
                                                      child: Text(value,style: const TextStyle(fontSize: 9),),
                                                    );
                                                  }).toList(),
                                                  value: state.dropVal,
                                                  onChanged: (val)=>bloc.changeDropVal(val!),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }
                            ),
                          ],
                        ),
                        const SizedBox(height: 10,),
                        if(state.images!.isEmpty && state.videoFile == null)...[
                          Column(
                            children: [
                              state.postBGImage == null ? AutoSizeTextField(
                                maxLines: null,
                                controller: state.postController,
                                // textAlign: TextAlign.center,
                                onTap: ()=> bloc.changeBottomSheetSize(),
                                decoration: InputDecoration(
                                  hintText: getTranslated(context, 'WRITE_SOMETHING')!,
                                  border: InputBorder.none,
                                ),
                              ): Container(
                                height: getHeight(context) / 4,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        fit:BoxFit.fill,
                                        image: AssetImage(
                                            state.postBGImage!
                                        )
                                    )
                                ),
                                child: Center(
                                  child: AutoSizeTextField(
                                    maxLines: null,
                                    style: state.captionTextStyle,
                                    controller: state.postController,
                                    textAlign: TextAlign.center,
                                    onTap: ()=> bloc.changeBottomSheetSize(),
                                    decoration: InputDecoration(
                                        hintText: getTranslated(context, 'WRITE_SOMETHING')!,
                                        border: InputBorder.none,
                                        hintStyle: state.captionTextStyle
                                    ),
                                    onChanged: (val){
                                      bloc.ontextControllerChange(val);
                                    },
                                  ),
                                ),
                              ),
                              SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: List.generate(8, (index) => Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: InkWell(
                                      onTap: ()=>bloc.changeBGImage(index),
                                      child: Container(
                                        height: 50,
                                        width: 50,
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage("${AssetConfig.postBgBase}bg$index.png")
                                            ),
                                            borderRadius: BorderRadius.circular(5)
                                        ),
                                      ),
                                    ),
                                  )),
                                ),
                              ),
                            ],
                          )
                        ]else if(state.videoFile != null)...[
                          Column(
                            children: [
                              AutoSizeTextField(
                                maxLines: null,
                                controller: state.postController,
                                // maxLines: null,
                                decoration:  InputDecoration(
                                    border: InputBorder.none,
                                    hintText: getTranslated(context, 'WRITE_SOMETHING')!
                                ),
                                onChanged: (val){
                                  bloc.ontextControllerChange(val);
                                },
                              ),
                              Container(
                                height: getHeight(context) / 3,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  color: Colors.black,
                                  image: DecorationImage(
                                      fit: BoxFit.cover,
                                    image: MemoryImage(state.videoFile!)
                                  )
                                ),
                                // height: getHeight(context)/4,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: IconButton(
                                        onPressed: (){
                                          context.read<PostCubit>().initVideo();
                                          Navigator.pushNamed(context, playVidePage);
                                          state.videoController!.play();
                                        },
                                        icon: const Icon(LineIcons.play,color: Colors.white,size: 40,),
                                      ),
                                    ),
                                    Align(
                                      alignment: Alignment.topRight,
                                      child: IconButton(
                                        onPressed: (){
                                          print(state.videoFilePath);
                                          nextScreen(context, VideoEditPage(path: state.videoFilePath!));
                                        },
                                        icon: const Icon(LineIcons.edit,color: Colors.white,),
                                      ) ,
                                    )
                                  ],
                                ),
                              )
                            ],
                          )
                        ]else ...[
                          Column(
                            children: [
                              AutoSizeTextField(
                                maxLines: null,
                                controller: state.postController,
                                // maxLines: null,
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: getTranslated(context, 'WRITE_SOMETHING')!
                                ),
                                onChanged: (val){
                                  bloc.ontextControllerChange(val);
                                },
                              ),
                              StaggeredGrid.count(
                                crossAxisCount: state.images!.length == 1 ? 1 : 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 12,
                                children: List.generate(state.images!.length, (index){
                                  return Container(
                                    decoration: const BoxDecoration(
                                      color: Colors.transparent,
                                      borderRadius: BorderRadius.all(
                                        Radius.circular(15),
                                      ),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                            Radius.circular(15)),
                                        child: Stack(
                                          children: [
                                            Image.file(File(state.images![index]),fit: BoxFit.fill,),
                                            Align(
                                              alignment: Alignment.topRight,
                                              child: IconButton(
                                                onPressed: ()=>bloc.clearImage(index),
                                                icon: const Icon(Icons.clear,color: Colors.white,),
                                              ),
                                            )
                                          ],
                                        )
                                    ),
                                  );
                                })
                              ),
                            ],
                          ),
                        ]
                      ],
                    ),
                  ),
                ),
              ),
              DraggableScrollableSheet(
                minChildSize: 0.1,
                initialChildSize: state.initChildSize,
                maxChildSize: 0.6,
                builder: (context, scrollController) => Card(
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      )),
                  child: Material(
                    elevation: 3,
                    child: ListView.builder(
                        padding: const EdgeInsets.all(0),
                        itemCount: state.bottomSheetWidgets.length,
                        controller: scrollController,
                        itemBuilder: (context, index) => InkWell(
                            onTap: (){
                              print(index);
                              if(index == 1){
                                bloc.pickImages();
                              }else if(index == 2){
                                bloc.pickVideo(context);
                              }else if(index == 3){
                                Navigator.push(context, MaterialPageRoute(builder: (context) => PlacesSelect()));
                              }else{
                                Navigator.push(context, ScaleRoute(page: RecordVideo()));
                                // nextScreen(context, RecordVideo());
                              }
                            },
                            child: state.bottomSheetWidgets[index])
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
