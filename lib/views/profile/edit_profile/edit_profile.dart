import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/components/secondry_button.dart';

import '../../../utils/constants.dart';
class EditProfile extends StatefulWidget {
  const EditProfile({Key? key}) : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  GlobalKey<FormState> key = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<ProfileCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<ProfileCubit,ProfileState>(
      builder: (context,state) {
        return Scaffold(
          appBar: AppBar(
            centerTitle: false,
            title: const Text("Edit Profile"),
          ),
          body: Padding(
            padding: const EdgeInsets.all(12.0),
            child: SingleChildScrollView(
              child: Form(
                key: key,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Profile Image",style: TextStyle(fontSize: 20,),),
                        TextButton(onPressed: ()=>Navigator.pushNamed(context, editProfileImage), child: const Text("Edit"))
                      ],
                    ),
                    Center(
                      child: CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage("${Utils.baseImageUrl}${state.profileImage}"),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text("Interests"),
                            TextButton(onPressed: (){}, child: Text("Edit"))
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 10,),
                    Divider(),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Personal Info",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    TextFormField(
                      validator: (val){
                        if(val!.isEmpty){
                          return "Please Enter Profile Name";
                        }else{
                          return null;
                        }
                      },
                      controller: TextEditingController(text: state.profileName),
                      decoration: const InputDecoration(
                          hintText: "Profile Name"
                      ),
                      onChanged: (val){
                        bloc.setProfileName(val);
                      },
                    ),
                    TextField(
                      controller: TextEditingController(text: state.city),
                      decoration: const InputDecoration(
                        hintText: "City"
                      ),
                      onChanged: (val){
                        bloc.setCityVal(val);
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Country"
                      ),
                      controller: TextEditingController(text: state.country),
                      onChanged: (val){
                        bloc.setCountryVal(val);
                      },
                    ),
                    TextField(
                      decoration: const InputDecoration(
                          hintText: "Phone No"
                      ),
                      controller: TextEditingController(text: state.phoneNo),
                      onChanged: (val){
                        bloc.setPhoneNum(val);
                      },
                    ),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Text("Material Status",style: TextStyle(fontSize: 20,),),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Container(
                      height: 45,
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: state.relationDropList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        }).toList(),
                        value: state.relationShip,
                        onChanged: (val)=>bloc.changeRelationDrop(val),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                    Container(
                      height: 45,
                      child: DropdownButton<String>(
                        underline: const Divider(color: Colors.grey,thickness: 1.5,),
                        isExpanded: true,
                        iconEnabledColor: kUniversalColor,
                        items: state.genderList.map((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(value),
                          );
                        },
                        ).toList(),
                        value: state.gender,
                        onChanged: (val)=>bloc.changeGenderDrop(val),
                        isDense: true,
                      ),
                    ),
                    const SizedBox(height: 20,),
                   state.isProfileUpdating ? CupertinoActivityIndicator() :
                   SecendoryButton(text: "Save", onPressed: ()=>bloc.updateUserProfileInfo(authBloc.userID!, authBloc.accesToken!))
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}
