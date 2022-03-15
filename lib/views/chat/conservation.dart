import 'dart:io';
import 'dart:typed_data';

import 'package:auto_size_text_field/auto_size_text_field.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emoji_picker_flutter/emoji_picker_flutter.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hapiverse/logic/chat/chat_cubit.dart';
import 'package:hapiverse/logic/profile/profile_cubit.dart';
import 'package:hapiverse/logic/register/register_cubit.dart';
import 'package:hapiverse/utils/utils.dart';
import 'package:hapiverse/views/chat/call_page.dart';
import 'package:hapiverse/views/chat/view_image.dart';
import 'package:hapiverse/views/components/universal_card.dart';
import 'package:image_picker/image_picker.dart';
import 'package:line_icons/line_icons.dart';

import '../../utils/constants.dart';

class ConservationPage extends StatefulWidget {
  final String recieverName;
  final String profileImage;
  final String recieverPhone;
  const ConservationPage({Key? key,required this.profileImage,required this.recieverPhone,required this.recieverName}) : super(key: key);

  @override
  _ConservationPageState createState() => _ConservationPageState();
}

class _ConservationPageState extends State<ConservationPage> {
  String text = '';
  TextEditingController message = TextEditingController();
  bool isEmojiOpen = true;
  onBackspacePressed() {
    message
      ..text = message.text.characters.skipLast(1).toString()
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }


  onEmojiSelected(Emoji emoji) {
    message
      ..text += emoji.emoji
      ..selection = TextSelection.fromPosition(
          TextPosition(offset: message.text.length));
  }
  bool isKeyboardOpen = false;
  int lastIndex = 0;
  final ScrollController _controller = ScrollController();
  // late AutoScrollController chatController;
  int messageCount = 0;
  bool isRecording = false;
  DateTime date = DateTime.now();
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool emojiShowing = false;
  Future<String> uploadImage(Uint8List? imageBytes, String cid, String filename,String userid) async {
    var snapshot = await FirebaseStorage.instance.ref().child('chats/${userid}/$cid/$filename${DateTime.now()}').putData(imageBytes!);
    var url = (await snapshot.ref.getDownloadURL()).toString();
    return url;
  }
  XFile? image;

  @override
  Widget build(BuildContext context) {
    final authB = context.read<RegisterCubit>();
    final chatBloc = context.read<ChatCubit>();
    final Stream<QuerySnapshot> documentStream = firestore.collection('chats').doc(authB.userID).collection(widget.recieverPhone).orderBy('timestamp').snapshots();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.recieverName),
        actions: [
          IconButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => CallPage()));
              },
              icon: const Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
  builder: (context, state) {
    return UniversalCard(
        widget: Column(
          children: [
            Expanded(
              child: StreamBuilder(
                stream: documentStream,
                builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
                  if(snapshot.data == null){
                    return Container();
                  }else{
                    lastIndex = snapshot.data!.docs.length;
                    print(snapshot.data!.docs.length);
                    print(lastIndex);
                    return ListView(
                      controller: _controller,
                      // physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      children: snapshot.data!.docs.map((DocumentSnapshot document) {
                        Map<String, dynamic> data = document.data()! as Map<String, dynamic>;
                        return Padding(
                          padding: EdgeInsets.all(10.0),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.end,
                            children: <Widget>[
                             if(data['messageType'] == 'text')...[
                                SizedBox(
                                  width: getWidth(context) / 1.5,
                                  child: Stack(
                                    children: [
                                      InkWell(
                                        child: Align(
                                          alignment: data['senderID'] == authB.userID ?  Alignment.centerRight :Alignment.centerLeft ,
                                          child: Material(
                                            borderRadius: data['senderID'] == authB.userID
                                                ? const BorderRadius.only(
                                                topLeft: Radius.circular(30.0),
                                                bottomLeft: Radius.circular(30.0),
                                                bottomRight: Radius.circular(30.0))
                                                : const BorderRadius.only(
                                              bottomLeft: Radius.circular(30.0),
                                              bottomRight: Radius.circular(30.0),
                                              topRight: Radius.circular(30.0),
                                            ),
                                            elevation: 5.0,
                                            color: data['senderID'] == authB.userID ? kUniversalColor : Colors.grey[200],
                                            child: Padding(
                                              padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
                                              child: Text(
                                                data['message'],
                                                style: TextStyle(
                                                  color: data['senderID'] == authB.userID ? Colors.white : Colors.black54,
                                                  fontSize: 15.0,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ]else if(data['messageType'] == 'image')...[
                                InkWell(
                                  onTap: (){
                                    nextScreen(context, ViewImage(userName: widget.recieverName, imageURl: data['message']));
                                  },
                                  child: Hero(
                                    tag: widget.recieverName,
                                    child: SizedBox(
                                      width:getWidth(context) / 1.9,
                                      child: Stack(
                                        children: [
                                          Align(
                                            alignment: data['senderID'] == authB.userID ? Alignment.centerRight : Alignment.centerLeft,
                                            child: Container(
                                              height: getHeight(context) / 5,
                                                // padding: const EdgeInsets.all(5),
                                                decoration: BoxDecoration(
                                                    // color: kUniversalColor,
                                                    borderRadius: BorderRadius.circular(10),
                                                  image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(data['message'],)
                                                  )
                                                ),
                                                width: getWidth(context) / 2,
                                               ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ]
                            ],
                          ),
                        );
                      }).toList(),
                    );
                  }
                },
              ),
            ),
            Wrap(
              children: [
                Card(
                  child: Row(
                    children: [
                      IconButton(onPressed: (){
                        setState(() {
                          isEmojiOpen = !isEmojiOpen;
                        });
                      }, icon: Icon(LineIcons.laughFaceWithBeamingEyes)),
                      Expanded(
                        child: AutoSizeTextField(
                          maxLines: null,
                          controller: message,
                          onTap: (){
                            setState(() {
                              isEmojiOpen = true;
                            });
                          },
                          onChanged: (v){
                            setState(() {
                              text = v;
                            });
                          },
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Enter a search term',
                          ),
                        ),
                      ),
                      text.isEmpty ? Row(
                        children: [
                          IconButton(
                            onPressed: ()async {
                              final ImagePicker _picker = ImagePicker();
                              var mage = await _picker.pickImage(
                                  source : ImageSource.gallery);
                              setState(() {
                                image = mage;
                              });
                              if (image == null) return;
                              var bytes = await image!.readAsBytes();
                              if(bytes != null) {
                                print(image!.path);
                                String filename = image!.path.split("/").last;
                                String imageUrl = await uploadImage(bytes, widget.recieverPhone, filename,authB.userID!);
                                print(imageUrl);
                                chatBloc.sendImageMessage(context, imageUrl, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,authB.userID!,state.profileName!,state.profileImage!).then((value) {
                                  setState(() {
                                    image = null;
                                  });
                                });
                                // _scrollDown();
                              }

                            },
                            icon: const Icon(
                              LineIcons.paperclip,
                              color: kUniversalColor,
                            ),
                          ),
                          IconButton(
                            onPressed: () {},
                            icon: const Icon(
                              Icons.mic,
                              color: kUniversalColor,
                            ),
                          ),
                        ],
                      ) :
                      IconButton(
                        onPressed: () {
                          print(message.text);
                          chatBloc.generateRandomString(13);
                          chatBloc.sendTextMessage(context, text, widget.recieverPhone, messageCount.toString(), widget.recieverName, widget.profileImage,authB.userID!,state.profileName!,"${Utils.baseImageUrl}${state.profileImage}");
                          message.clear();
                        },
                        icon: const Icon(
                          Icons.send,
                          color: kUniversalColor,
                        ),
                      ),
                    ],
                  ),
                ),
                Offstage(
                  offstage: isEmojiOpen,
                  child: SizedBox(
                    height: 250,
                    child: EmojiPicker(
                        onEmojiSelected: (Category category, Emoji emoji) {
                          onEmojiSelected(emoji);
                        },
                        onBackspacePressed: onBackspacePressed,
                        config: Config(
                            columns: 7,
                            // Issue: https://github.com/flutter/flutter/issues/28894
                            emojiSizeMax: 32 * (Platform.isIOS ? 1.30 : 1.0),
                            verticalSpacing: 0,
                            horizontalSpacing: 0,
                            initCategory: Category.RECENT,
                            bgColor: const Color(0xFFF2F2F2),
                            indicatorColor: Colors.blue,
                            iconColor: Colors.grey,
                            iconColorSelected: Colors.blue,
                            progressIndicatorColor: Colors.blue,
                            backspaceColor: Colors.blue,
                            showRecentsTab: true,
                            recentsLimit: 28,
                            noRecentsText: 'No Recents',
                            noRecentsStyle: const TextStyle(
                                fontSize: 20, color: Colors.black26),
                            tabIndicatorAnimDuration: kTabScrollDuration,
                            categoryIcons: const CategoryIcons(),
                            buttonMode: ButtonMode.MATERIAL)),
                  ),),
              ],
            )
          ],
        ),
      );
  },
),
    );
  }
}
