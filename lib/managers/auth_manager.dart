import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../constants.dart';

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
      bool shouldCallCallback = _user != user;
      _user = user;
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
      if (_callbackFcn != null && shouldCallCallback) {
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

  void listenForRedirects(context) {
    print("listenForRedirects called");
    AuthManager().setListener(() {
      print("Auth state change");
      var routeName = ModalRoute.of(context)?.settings?.name;

      print("Route: $routeName");

      bool isOnANoUserScreen = routeName == null ||
          routeName == kRouteWelcome ||
          routeName == kRouteLogin ||
          routeName == kRouteRegistration;
      // Welcome||login||reg||null && signedIn --> go to chat
      // !(Welcome||login||reg||null) && !signedIn --> go to welcome

      if (AuthManager().isSignedIn && isOnANoUserScreen) {
        print("Signed in so go to the chat screen");
        Navigator.pushNamed(context, kRouteChat);
      }
      if (!AuthManager().isSignedIn && !isOnANoUserScreen) {
        print("Not Signed in so go back to the welcome screen");
        Navigator.pushNamed(context, kRouteWelcome);
      }
    });
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
