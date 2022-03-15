import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/components/universal_card.dart';
class AddMembersToGroup extends StatefulWidget {
  final String groupId;
  const AddMembersToGroup({Key? key,required this.groupId}) : super(key: key);
  @override
  _AddMembersToGroupState createState() => _AddMembersToGroupState();
}

class _AddMembersToGroupState extends State<AddMembersToGroup> {
  List<String> invited = [];
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Invite Members"),
      ),
      body: UniversalCard(
        widget: FutureBuilder(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
            if(snapshot.hasData){
              return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document){
                    Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                    if(data['email'] == authB.userID){
                      return Container();
                    }else{
                      return ListTile(
                        contentPadding: const EdgeInsets.all(8),
                        leading: CircleAvatar(
                          foregroundColor: Colors.grey[300],
                          backgroundImage: NetworkImage(data['profile_url']),
                        ),
                        title: Text(data['name']),
                        trailing: invited.contains(document.id) ? Container(
                          padding: const EdgeInsets.symmetric(horizontal: 18,vertical: 8),
                          decoration: BoxDecoration(
                              border: Border.all(color: kSecendoryColor),
                              borderRadius: BorderRadius.circular(30)
                          ),
                          child: Text("Invited"),
                        ):MaterialButton(
                          color: kSecendoryColor,
                          shape: StadiumBorder(),
                          onPressed: (){
                            setState(() {
                              invited.add(document.id);
                            });
                            Map<String, dynamic> map={
                              'name':data['name'],
                              'userId':data['email'],
                              'role':'member',
                              'image': data['profile_url'],
                              'status': 'pending',
                            };
                            FirebaseFirestore.instance.collection('groups').doc(widget.groupId).collection('members').doc(map['userId']).set(map);
                            FirebaseFirestore.instance.collection('groups').doc(widget.groupId).collection('members').get().then((value){
                              FirebaseFirestore.instance.collection('groups').doc(widget.groupId).update({
                                'members':value.docs.length
                              });
                            });
                            FirebaseFirestore.instance.collection('groups').doc(widget.groupId).get().then((gdata){
                              FirebaseFirestore.instance.collection('users').doc(map['userId']).collection('groupsRequests').add({
                                'groupName':gdata.data()?['groupName'],
                                'cover':gdata.data()?['cover'],
                                'privacy':gdata.data()?['Privacy'],
                                'members':gdata.data()?['members'],
                              });
                            });
                          },
                          child: Text("Invite",style: TextStyle(color: Colors.white),),
                        ),
                      );
                    }
                  }).toList()
              );
            }else if(snapshot.connectionState == ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(),);
            }else{
              return Text("Something Went Wrong");
            }
          }),
        ),
    );
  }
}
