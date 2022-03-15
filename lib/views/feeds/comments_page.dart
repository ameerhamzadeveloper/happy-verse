import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/constants.dart';

class CommentPage extends StatelessWidget {
  final CollectionReference? ref;

  const CommentPage({Key? key, this.ref}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String text = '';
    TextEditingController message = TextEditingController();
    final authB = context.read<RegisterCubit>();
    return Scaffold(
      // resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text("Add Comment"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                StreamBuilder(
                  stream: ref!.snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.hasData) {
                      return Expanded(
                        // height: getHeight(context) - 200,
                        child: ListView(
                            shrinkWrap: true,
                            children: snapshot.data!.docs.map((
                                DocumentSnapshot document) {
                              Map<String, dynamic> data = document.data()! as Map<
                                  String,
                                  dynamic>;
                              return ListTile(
                                title: Text(data['name']),
                                subtitle: Text(data['title']),
                                leading: CircleAvatar(
                                  backgroundImage: NetworkImage(data['ProfilePic']),
                                ),
                                trailing: Icon(Icons.more_horiz),
                              );
                            }).toList()
                        ),
                      );
                    } else
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator(),);
                    } else if (snapshot.data!.docs.isEmpty) {
                      return Text("No Comments");
                    }
                    return Text("Something Went Wrong");
                  },
                ),
                // Spacer(),
                Wrap(
                  children: [
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: AutoSizeTextField(
                          maxLines: null,
                          controller: message,
                          onChanged: (val){
                            text = val;
                          },
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Write Something',
                            suffixIcon: IconButton(
                              onPressed: () {
                                FirebaseFirestore.instance.collection('users')
                                    .doc(authB.userID).get()
                                    .then((value) {
                                  ref!.add({
                                    'name': value.data()?['name'],
                                    'ProfilePic': value.data()?['profile_url'],
                                    'title': text,
                                    'timeStamp': DateTime.now(),
                                  });
                                });
                                message.clear();
                              },
                              icon: const Icon(
                                Icons.send,
                                color: kUniversalColor,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ]
          ),
        ),
      ),
    );
  }
}
