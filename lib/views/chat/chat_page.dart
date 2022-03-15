import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/routes/routes_names.dart';
import 'package:hapiverse/utils/constants.dart';
import 'package:hapiverse/views/chat/conservation.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:intl/intl.dart';
import 'package:jiffy/jiffy.dart';
import 'package:line_icons/line_icons.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final Stream<QuerySnapshot> documentStream = firestore.collection('recentChats').doc(authB.userID).collection('myChats').orderBy('timestamp',descending: true).snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(getTranslated(context, 'CHAT')!),
      ),
      body: UniversalCard(
        widget: Column(
          children: [
            Container(
              height: 30,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(10),
              ),
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: TextField(
                  // autofocus: true,
                  decoration: InputDecoration(
                      hintText: "Search",
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: Icon(Icons.search,size: 20,),
                        onPressed: () {},
                      )),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            StreamBuilder(
              stream: documentStream,
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                if(snapshot.data == null){
                  return Center(child: Text("No Message"),);
                }else if(snapshot.hasData){
                  return ListView(
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document){
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Slidable(
                          key: const ValueKey(0),
                          endActionPane: ActionPane(
                            extentRatio: 0.2,
                            motion: ScrollMotion(),
                            children: [
                              SlidableAction(
                                // An action can be bigger than the others.
                                onPressed: (v){},
                                // backgroundColor: Colors.red,
                                foregroundColor: Colors.red,
                                icon: LineIcons.trash,
                                label: 'Delete',
                              ),
                            ],
                          ),
                          child: ListTile(
                            onTap: (){
                              nextScreen(context, ConservationPage(profileImage: data['profileImage'], recieverPhone: data['recieverID'] == authB.userID ? data['senderID'] : data['recieverID'], recieverName: data['recieverName']));
                            },
                            leading: CircleAvatar(
                              radius: 25,
                              backgroundImage: NetworkImage(data['profileImage']),
                            ),
                            title: Text(data['recieverName']),
                            subtitle: data['messageType'] == 'image'? Row(
                              children: [
                                Icon(Icons.image,size: 15,),
                                SizedBox(width: 2,),
                                Text("Image")
                              ],
                            ):Text(data['lastMessage'].toString().length > 24 ? "${data['lastMessage'].toString().substring(0,24)}..." : data['lastMessage'].toString()),
                            trailing: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(Jiffy(data['timestamp'].toDate(), "MM dd, yyyy at hh:mm a").fromNow().toString(),style: const TextStyle(fontSize: 11),),
                                data['senderID'] == authB.userID ? const Text(""):CircleAvatar(
                                  radius: 10,
                                  backgroundColor: kUniversalColor,
                                  child: Text(data['count'].toString(),style: TextStyle(fontSize: 11),),
                                )
                              ],
                            ),
                          ),
                        );
                      }).toList()
                  );
                }else if(snapshot.connectionState == ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(),);
                }else{
                  return Center(child: Text("Something Went Wrong"),);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
