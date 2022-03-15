import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/secondry_button.dart';
import 'package:line_icons/line_icons.dart';

import '../../../utils/utils.dart';

class EditProfileImage extends StatefulWidget {
  const EditProfileImage({Key? key}) : super(key: key);

  @override
  _EditProfileImageState createState() => _EditProfileImageState();
}

class _EditProfileImageState extends State<EditProfileImage> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final autBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Edit Profile Image"),
          ),
          body: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: getHeight(context) / 6,
              ),
              state.profileUpdatedImage == null
                  ? Center(
                      child: CircleAvatar(
                        radius: 110,
                        backgroundImage: NetworkImage(
                            "${Utils.baseImageUrl}${state.profileImage}"),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        radius: 110,
                        backgroundImage: FileImage(
                            File(state.profileUpdatedImage!.path)),
                      ),
                    ),
              SizedBox(
                height: 40,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () => bloc.getImageGallery(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Center(
                        child: Column(
                          children: [Icon(LineIcons.image), Text("Gallery")],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  InkWell(
                    onTap: () => bloc.getImageCamera(),
                    child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 3.0),
                        child: Center(
                          child: Column(
                            children: [Icon(LineIcons.camera), Text("Camera")],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10,),
              state.profileUpdatedImage == null ?
              Container():
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: (){
                      bloc.cropImage();
                    },
                    child: Container(
                      padding: EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30.0),
                        child: Center(
                          child: Row(
                            children: [Icon(LineIcons.crop), Text("Crop")],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.all(12.0),
            child: state.isProfileUpdating ? const Center(child: CircularProgressIndicator()):SecendoryButton(
              onPressed: () =>bloc.updateUserProfileImage(autBloc.userID!, autBloc.accesToken!, context),
              text: "Save",
            ),
          ),
        );
      },
    );
  }
}
