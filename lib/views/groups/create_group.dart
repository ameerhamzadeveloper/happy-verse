import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/groups/groups_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/secondry_button.dart';
import 'package:hapiverse/views/components/universal_card.dart';
class CreateGroups extends StatefulWidget {
  const CreateGroups({Key? key}) : super(key: key);
  @override
  _CreateGroupsState createState() => _CreateGroupsState();
}

class _CreateGroupsState extends State<CreateGroups> {

  GlobalKey<FormState> keye = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<GroupsCubit>();
    final authBloc = context.read<RegisterCubit>();
    return BlocBuilder<GroupsCubit,GroupsState>(
      builder: (context,state) {
        return Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(
            title: Text(getTranslated(context, 'CREATE_GROUP')!),
          ),
          body: Column(
            children: [
              Expanded(
                child: Card(
                  child: Form(
                    key: keye,
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(getTranslated(context, 'ADD_BANNER')!,style: TextStyle(fontSize: 20),),
                          SizedBox(height: 10,),
                          state.groupCover == null ? Container(
                            width: double.infinity,
                            height: getHeight(context) / 5,
                            decoration: BoxDecoration(
                                color: Colors.grey[400],
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.image,size: 100,color: Colors.grey,),
                                MaterialButton(
                                  color: Colors.grey,
                                    onPressed: ()=>bloc.getImage(),
                                  child: Text(getTranslated(context, 'ADD_IMAGE')!),
                                )
                              ],
                            ),
                          ):
                          Container(
                            width: double.infinity,
                            height: getHeight(context) / 5,
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                  fit: BoxFit.fill,
                                  image: FileImage(File(state.groupCover!.path))
                                ),
                                borderRadius: BorderRadius.circular(20)
                            ),
                          ),
                          state.groupCover == null ? Container():TextButton(onPressed: ()=>bloc.getImage(), child: const Text("Change Image")),
                          Text(state.error,style: TextStyle(color: Colors.red),),
                          SizedBox(height: 20,),
                          Text(getTranslated(context, 'NAME')!),
                          SizedBox(height: 10,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()
                            ),
                            padding: const EdgeInsets.only(left: 8),
                            child: TextFormField(
                              validator: (val){
                                if(val!.isEmpty){
                                  return getTranslated(context, 'GROUP_NAME_IS_REQUIRED')!;
                                }
                                return null;
                              },
                              onChanged: (val){
                                bloc.assignName(val);
                              },
                              decoration: InputDecoration(
                                  hintText: getTranslated(context, 'NAME_YOUR_GROUP')!,
                                  border: InputBorder.none
                              ),
                            ),
                          ),
                          SizedBox(height: 20,),
                          Divider(),
                          SizedBox(height: 20,),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all()
                            ),
                            padding: const EdgeInsets.only(left: 8,right: 8),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                value: state.privacyValue,
                                items: state.privacyDownValue.map((e){
                                  return DropdownMenuItem(
                                    child: Text(e),
                                    value: e,
                                  );
                                }).toList(),
                                onChanged: (val)=>bloc.changePrivacyValue(val!),
                                isExpanded: true,
                                hint: Text("Chose Privacy"),
                              ),
                            ),
                          ),
                          const Spacer(),
                          state.isSub ? Center(child: const CircularProgressIndicator()):SecendoryButton(text: getTranslated(context, 'CREATE_GROUP')!, onPressed: (){
                            if(keye.currentState!.validate()){
                              if(state.groupCover != null){
                                bloc.assignisSub();
                                bloc.createGroup(authBloc.userID!,context,authBloc.accesToken!);
                              }else{
                                bloc.assignErro(getTranslated(context, 'BANNER_IS_REQUIRED')!);
                              }
                            }

                          })
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          )
        );
      }
    );
  }
}
