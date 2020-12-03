import 'package:flutter/material.dart';

class Message {
  String text;
  String senderUid;

  Message({@required this.text, @required this.senderUid});

  @override
  String toString() {
    return "Text: $text   SenderUid: $senderUid";
  }
}
