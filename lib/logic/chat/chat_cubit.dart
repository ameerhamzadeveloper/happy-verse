import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:meta/meta.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitial());

  DateTime date = DateTime.now();
  String docId = '';
  FirebaseFirestore firestore = FirebaseFirestore.instance;


  String generateRandomString(int len) {
    var r = Random();
    const _chars = 'BCDEFGxcbHIJKLsdfdMNOPhfQRSTUdfdfcvVWXYZ';
    docId = List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
    return List.generate(len, (index) => _chars[r.nextInt(_chars.length)]).join();
  }

  sendTextMessage(BuildContext context,String message,String recieverPhone,String messageCount,String recieverName,String profileImage,String userID,String userName,String userProfile){
    print("here");
    print(message);
    firestore.collection('chats').doc(userID).collection(recieverPhone).doc(docId).set({
      'message': message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userName,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'text',
      'isFavorite':false,
      'id':docId,
    });
    firestore.collection('chats').doc(recieverPhone).collection(userID).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userName,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      'isFavorite':false,
      'id':docId,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userName,
      'recieverName':userName,
      'profileImage':userName,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'text',
      // 'token': widget.fcmToken,
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'text',
      // 'token':widget.fcmToken,
    });
  }



  Future<bool> sendImageMessage(BuildContext context,message,String recieverPhone,String messageCount,String recieverName,String profileImage,String userID,String userName,String userProfile)async{

    firestore.collection('chats').doc(userID).collection(recieverPhone).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'image',
      'isFavorite':false,
      'id':docId,
    });
    firestore.collection('chats').doc(recieverPhone).collection(userID).doc(docId).set({
      'message':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'image',
      'isFavorite':false,
      'id':docId,
    });
    firestore.collection('recentChats').doc(recieverPhone).collection('myChats').doc(userID).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':userName,
      'profileImage':userProfile,
      'count':messageCount,
      'isSendMe':false,
      'isSeen':false,
      'isOnline':false,
      'messageType': 'image',
      // 'token': widget.fcmToken,
    });
    firestore.collection('recentChats').doc(userID).collection('myChats').doc(recieverPhone).set({
      'lastMessage':message,
      'date': "${date.year}/${date.month}/${date.day}",
      'timestamp':DateTime.now(),
      'recieverID':recieverPhone,
      'senderID':userID,
      'recieverName':recieverName,
      'profileImage':profileImage,
      'count':messageCount,
      'isSendMe':true,
      'isSeen':false,
      'isOnline':true,
      'messageType': 'image',
      // 'token':widget.fcmToken,
    });
    return true;
  }
}
