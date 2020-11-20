import 'package:firebase_auth/firebase_auth.dart';

class AuthManager {
  final _auth = FirebaseAuth.instance;

// Boilerplate code that make a singleton (don't delete)
  static final AuthManager _instance = AuthManager._privateConstructor();
  AuthManager._privateConstructor();
  factory AuthManager() {
    return _instance;
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
}
