import 'dart:io';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/config/assets_config.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/profile/components/clip_path.dart';
import 'package:line_icons/line_icons.dart';
class CreateProfile extends StatefulWidget {
  const CreateProfile({Key? key}) : super(key: key);

  @override
  _CreateProfileState createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  DateFormat dateFormat =  DateFormat('dd / MMM / yyyy');
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return BlocBuilder<RegisterCubit,RegisterState>(
      builder: (context,state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(
            children: [
              ClipPath(
                clipper: ProfileClipPath(),
                child: Container(
                  height: getHeight(context) / 3,
                  color: kUniversalColor,
                ),
              ),
              state.profileImagePath == null ? Align(
                alignment: const Alignment(0.0,-0.5),
                child: Container(
                  height: getWidth(context) / 3,
                  width: getWidth(context) / 4,
                  decoration: BoxDecoration(
                    color: kUniversalColor,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white,width: 3),
                    image: const DecorationImage(
                      fit: BoxFit.fill,
                      image: AssetImage(
                        AssetConfig.kLogo
                      )
                    )
                  ),
                ),
              ):
              Align(
                alignment: const Alignment(0.0,-0.5),
                child: Container(
                  height: getWidth(context) / 3,
                  width: getWidth(context) / 4,
                  decoration: BoxDecoration(
                      color: kUniversalColor,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white,width: 3),
                      image:  DecorationImage(
                          fit: BoxFit.fill,
                          image: FileImage(File(state.profileImagePath!))
                      )
                  ),
                ),
              ),
               Align(
                alignment: const Alignment(0.0,-0.2),
                child: Text(state.fullName!,style: TextStyle(fontSize: 22),),
              ),

              Align(
                alignment: Alignment.bottomCenter,
                child: SizedBox(
                  height: getHeight(context) / 1.8,
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Text(state.errorMessage,style: const TextStyle(color: Colors.red),),
                            ],
                          ),
                          TextFormField(
                            onChanged: (val)=>bloc.setHobby(val),
                            decoration: const InputDecoration(
                                labelText: "Hobbie",
                                hintText: "eg: footbal",
                                suffixIcon: Icon(LineIcons.walking)),
                          ),
                          const SizedBox(height: 20),
                          InkWell(
                            onTap: (){
                              DateTime d = DateTime.now();
                              DatePicker.showDatePicker(
                                  context,
                                  showTitleActions: true,
                                  minTime: DateTime(1940, 3, 5),
                                  onChanged: (date) =>bloc.changeDate(date),
                                  onConfirm: (date) {},
                                  currentTime: DateTime.now(),
                              );
                            },
                            child: SizedBox(
                              height: 40,
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Icon(LineIcons.birthdayCake),
                                    Text(dateFormat.format(state.dateOfBirth).toString()),
                                    Icon(Icons.arrow_drop_down_sharp)
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const Divider(color: Colors.grey,thickness: 1.5,),
                          const SizedBox(height: 20,),
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
                              value: state.relationVal,
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
                              value: state.genderVal,
                              onChanged: (val)=>bloc.changeGenderDrop(val),
                              isDense: true,
                            ),
                          ),
                          const SizedBox(height: 40,),
                          state.loadingState ? const Center(child: CircularProgressIndicator(),):MaterialButton(
                            minWidth: getWidth(context) / 3,
                            shape: const StadiumBorder(),
                            color: kSecendoryColor,
                            onPressed: (){
                              if(state.profileImagePath == null){
                                bloc.imageNotSelected();
                              }else{
                                bloc.createProfile(context);
                              }
                            },
                            child: const Text("Done",style: TextStyle(color: Colors.white),),
                          ),
                          const SizedBox(height: 50,)
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: getHeight(context),
                width: getWidth(context),
                child: Align(
                  alignment: const Alignment(0.3,-0.4),
                  child: IconButton(onPressed: ()=>bloc.getImage(), icon: Icon(LineIcons.camera,size: 30,)),
                ),
              ),
            ],
          ),
        );
      }
    );
  }
}
