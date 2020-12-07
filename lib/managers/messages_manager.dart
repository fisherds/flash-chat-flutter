import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/model_objects/Message.dart';

class MessagesManager {
  Function _callbackFcn;
  CollectionReference _ref;
  bool _waiting = true;
  bool _hasError = false;
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

  onData(QuerySnapshot querySnapshot) {
    _waiting = false;
    _hasError = false;
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
  }

  onError(error) {
    print("There was an error $error");
    _hasError = true;
  }

  beginListening(Function callbackFcn) {
    _callbackFcn = callbackFcn;
    _ref
        // .orderBy(kFbMessageCreated, descending: true)
        .orderBy(kFbMessageCreated)
        .limit(50)
        .snapshots()
        .listen(onData, onError: onError);
  }

  int get length => _docs.length;

  bool get isEmpty => _docs.length == 0;

  List<DocumentSnapshot> get docs => _docs;

  bool get hasError => _hasError;

  bool get isWaiting => _waiting;

  Stream get stream => _ref.snapshots();

  // Message getMessageAtIndex(int index) {
  // DocumentSnapshot doc = _docs[index];
  // return Message(
  //     text: doc.get(kFbMessageText), senderUid: doc.get(kFbMessageSenderUid));
  // }

  Message getMessageAt(int index) => Message(docs[index]);

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
