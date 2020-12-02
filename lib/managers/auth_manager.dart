import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  FirebaseAuth _auth;
  User _user;
  Function _callbackFcn;

  // Boilerplate code that make a singleton (don't delete)
  static final AuthManager _instance = AuthManager._privateConstructor();
  AuthManager._privateConstructor();
  factory AuthManager() {
    return _instance;
  }

  beginListening() {
    _auth = FirebaseAuth.instance;
    FirebaseAuth.instance.authStateChanges().listen((User user) {
      _user = user;
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      if (_callbackFcn != null) {
        _callbackFcn();
      }
    });
  }

  void setListener(Function callback) {
    _callbackFcn = callback;
  }

  void stopListening() {
    _callbackFcn = null;
  }

  Future<UserCredential> createUser(email, password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error with create user: $e");
      return null;
    }
  }

  Future<UserCredential> logInExistingUser(email, password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } catch (e) {
      print("Error with sign: $e");
      return null;
    }
  }

  void signOut() {
    _auth.signOut();
  }

  String get uid => _user?.uid ?? "";

  String get email => _user?.email ?? "";

  bool get isSignedIn => _user != null;
}
