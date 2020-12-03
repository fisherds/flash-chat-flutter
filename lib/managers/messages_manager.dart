import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/model_objects/Message.dart';

class MessagesManager {
  Function _callbackFcn;
  CollectionReference _ref;
  var _docs = List<DocumentSnapshot>();

  // Boilerplate code that make a singleton (don't delete)
  static final MessagesManager _instance =
      MessagesManager._privateConstructor();
  MessagesManager._privateConstructor() {
    print("Created the Messages Manager");
    _ref = FirebaseFirestore.instance.collection(kFbMessagesCollectionPath);
  }
  factory MessagesManager() {
    return _instance;
  }

  beginListening(Function callbackFcn) {
    _callbackFcn = callbackFcn;
    _ref.snapshots().listen((querySnapshot) {
      _docs = querySnapshot.docs; // Save the data
      // Print the documents
      for (DocumentSnapshot doc in querySnapshot.docs) {
        print(doc.data());
      }
      if (_callbackFcn != null) {
        _callbackFcn();
      }
    });
  }

  int get length => _docs.length;

  Message getMessageAtIndex(int index) {
    DocumentSnapshot doc = _docs[index];
    return Message(
        text: doc.get(kFbMessageText), senderUid: doc.get(kFbMessageSenderUid));
  }

  stopListening() {
    _callbackFcn = null;
  }

  Future<void> addMessage(String message, String uid) {
    return _ref
        .add({
          kFbMessageText: message,
          kFbMessageSenderUid: uid,
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }
}
