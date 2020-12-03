import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class Message {
  String text;
  String senderUid;

  // Message({@required this.text, @required this.senderUid});

  // static Message from(DocumentSnapshot doc) {
  //   var message = Message();
  //   message.text = doc.get(kFbMessageText);
  //   message.senderUid = doc.get(kFbMessageSenderUid);
  //   return message;
  // }

  Message(DocumentSnapshot doc) {
    text = doc.get(kFbMessageText);
    senderUid = doc.get(kFbMessageSenderUid);
  }

  @override
  String toString() {
    return "Text: $text   SenderUid: $senderUid";
  }
}
