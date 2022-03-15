import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:video_thumbnail/video_thumbnail.dart';
import '../../utils/constants.dart';

class ProfileImagesWidget extends StatelessWidget {
  final bool isMyProfile;
  const ProfileImagesWidget({Key? key,required this.isMyProfile}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        if(isMyProfile){
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10,),
              Text(getTranslated(context, 'PHOTO')!,style: TextStyle(color: kUniversalColor),),
              const SizedBox(height: 10,),
              state.allMyPosts == null ? Center(
                child: const CupertinoActivityIndicator(),
              ):GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.allMyPosts!.length,
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 100,
                    childAspectRatio: 2 / 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10),
                itemBuilder: (ctx, i) {
                  if(state.allMyPosts == null){
                    return InkWell(
                      // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                      child: Stack(
                        children: [
                          Card(
                            color: Colors.grey[400],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  image: const DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage("https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg")
                                  )
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }else if(state.allMyPosts!.isEmpty){
                    return Text("No Posts");
                  }else{
                    if(state.allMyPosts![i].contentType == 'text'){
                      return Container();
                    }else if(state.allMyPosts![i].contentType == 'video'){
                      return Card(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20)),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                                fit: BoxFit.cover,
                                image: FileImage(getVideoThumbnail("${Utils.baseImageUrl}${state.allMyPosts![i].postFiles![0].postFileUrl}"))
                            ),
                          ),
                        ),
                      );
                    }else{
                      return InkWell(
                        // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("${Utils.baseImageUrl}${state.allMyPosts![i].postFiles![0].postFileUrl}")
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                },
              ),
            ],
          );
        }else{
          // others profile posts
          if(state.allOtherPosts == null){
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                const Text("Photos",style: TextStyle(color: kUniversalColor),),
                Center(child: CupertinoActivityIndicator(),),
              ],
            );
          }else{
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10,),
                const Text("Photos",style: TextStyle(color: kUniversalColor),),
                const SizedBox(height: 10,),
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.allOtherPosts!.length,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 100,
                      childAspectRatio: 2 / 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10),
                  itemBuilder: (ctx, i) {
                    if(state.allOtherPosts == null){
                      return InkWell(
                        // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                        child: Stack(
                          children: [
                            Card(
                              color: Colors.grey[400],
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20)),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: const DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage("https://i.pinimg.com/736x/b8/03/78/b80378993da7282e58b35bdd3adbce89.jpg")
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }else if(state.allOtherPosts!.isEmpty){
                      return Text("No Posts");
                    }else{
                      if(state.allOtherPosts![i].contentType == 'text'){
                        return Container();
                      }else if(state.allOtherPosts![i].contentType == 'video'){
                        return Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: FileImage(getVideoThumbnail("${Utils.baseImageUrl}${state.allOtherPosts![i].postFiles![0].postFileUrl}"))
                              ),
                            ),
                          ),
                        );
                      }else{
                        return InkWell(
                          // onTap: () =>context.read<RegisterCubit>().onIntrestSelect(i),
                          child: Stack(
                            children: [
                              Card(
                                color: Colors.white,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage("${Utils.baseImageUrl}${state.allOtherPosts![i].postFiles![0].postFileUrl}")
                                      )
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                    }
                  },
                ),
              ],
            );
          }
        }
      }
    );
  }
  getVideoThumbnail(String path)async{
    print("Function Called");
    String? videoThumb = await VideoThumbnail.thumbnailFile(
      video: path,
      imageFormat: ImageFormat.JPEG,
      maxWidth: 128, // specify the width of the thumbnail, let the height auto-scaled to keep the source aspect ratio
      quality: 100,
    );
    print("video thumb $videoThumb");
    return videoThumb;
  }

}
