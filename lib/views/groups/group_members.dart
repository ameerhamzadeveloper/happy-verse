import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/views/components/universal_card.dart';

import '../../utils/constants.dart';
class GroupMembers extends StatefulWidget {
  final String id;
  const GroupMembers({Key? key,required this.id}) : super(key: key);

  @override
  _GroupMembersState createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  Widget build(BuildContext context) {
    final bloc = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Members"),
      ),
      body: UniversalCard(
        widget: FutureBuilder(
          future: FirebaseFirestore.instance.collection('groups').doc(widget.id).collection('members').get(),
          builder: (context,AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context,i){
                  var d = snapshot.data!.docs[i];
                  var isAdmin = snapshot.data!.docs[0]['role'] == 'admin' ? true : false;
                  return ListTile(
                    title: Text(d['name']),
                    leading: CircleAvatar(
                      backgroundColor: Colors.grey[300],
                      backgroundImage: NetworkImage(d['image']),
                    ),
                    trailing: isAdmin ? MaterialButton(
                      color: kSecendoryColor,
                      shape: StadiumBorder(),
                      onPressed: (){

                      },
                      child: Text("Remove",style: TextStyle(color: Colors.white),),
                    ):Text(d['role'])
                  );
                },
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return Text("Something Went Wrong");
            }
          },
        ),
      ),
    );
  }
}
