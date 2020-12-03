import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flash_chat/managers/messages_manager.dart';
import 'package:flash_chat/model_objects/Message.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ChatScreen extends StatefulWidget {
  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageTextController = TextEditingController();
  String messageBeingTyped = "";

  @override
  void initState() {
    print("Email ${AuthManager().email}");

    MessagesManager().beginListening(() {
      print("called the callback");

      print("Recieved ${MessagesManager().length} messages");

      if (MessagesManager().length > 0) {
        print(MessagesManager().getMessageAt(0));
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: null,
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.close),
              onPressed: () {
                //Implement logout functionality
                AuthManager().signOut();
                Navigator.pop(context);
              }),
        ],
        title: Text('⚡️Chat'),
        backgroundColor: Colors.lightBlueAccent,
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            StreamBuilder<QuerySnapshot>(
              stream: MessagesManager().stream,
              builder: (context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                    child: Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.lightBlueAccent,
                      ),
                    ),
                  );
                }

                final docs = snapshot.data.docs;
                // List<Text> messageWidgets = [];
                // for (var doc in docs) {
                //   final message = Message(doc);
                //   final messageWidget = Text(message.toString());
                //   messageWidgets.add(messageWidget);
                // }
                // return Column(
                //   children: messageWidgets,
                // );

                return Expanded(
                  child: ListView(
                      children: docs.map((DocumentSnapshot doc) {
                    return MessageBubble(Message(doc));
                  }).toList()),
                );
              },
            ),
            Container(
              decoration: kMessageContainerDecoration,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: messageTextController,
                      onChanged: (value) {
                        //Do something with the user input.
                        messageBeingTyped = value;
                        // print(messageBeingTyped);
                      },
                      decoration: kMessageTextFieldDecoration,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      messageTextController.clear();
                      MessagesManager()
                          .addMessage(messageBeingTyped, AuthManager().uid);
                    },
                    child: Text(
                      'Send',
                      style: kSendButtonTextStyle,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final Message message;
  MessageBubble(this.message);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Text(
            message.senderUid,
            style: TextStyle(
              fontSize: 12.0,
              color: Colors.black54,
            ),
          ),
          Material(
            elevation: 5.0,
            borderRadius: BorderRadius.circular(20.0),
            color: Colors.lightBlueAccent,
            child: ListTile(
              title: Text(
                message.text,
                style: TextStyle(fontSize: 24.0),
              ),
              // subtitle: Text(message.senderUid),
            ),
          ),
        ],
      ),
    );
  }
}
