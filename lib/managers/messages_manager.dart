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
    _ref
        .orderBy(kFbMessageCreated, descending: true)
        .limit(50)
        .snapshots()
        .listen((QuerySnapshot querySnapshot) {
      _docs = querySnapshot.docs; // Save the data
      // Print the documents
      // querySnapshot.docs.forEach((doc) {
      //   print(doc.data());
      // });
      // Another way to print:
      // for (DocumentSnapshot doc in querySnapshot.docs) {
      //   print(doc.data());
      // }
      if (_callbackFcn != null) {
        _callbackFcn();
      }
    });
  }

  int get length => _docs.length;

  Stream get stream => _ref.snapshots();

  // Message getMessageAtIndex(int index) {
  // DocumentSnapshot doc = _docs[index];
  // return Message(
  //     text: doc.get(kFbMessageText), senderUid: doc.get(kFbMessageSenderUid));
  // }

  Message getMessageAt(int index) => Message(_docs[index]);

  stopListening() {
    _callbackFcn = null;
  }

  Future<void> addMessage(String message, String uid) {
    return _ref
        .add({
          kFbMessageText: message,
          kFbMessageSenderUid: uid,
          kFbMessageCreated: FieldValue.serverTimestamp(),
        })
        .then((value) => print("Message Added"))
        .catchError((error) => print("Failed to add message: $error"));
  }
}
