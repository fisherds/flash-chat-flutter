import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

import 'managers/auth_manager.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatefulWidget {
  FlashChatState createState() => FlashChatState();
}

class FlashChatState extends State {
  // Set default `_initialized` and `_error` state to false
  bool _initialized = false;
  bool _error = false;
  int builderCounter = 0;

  // Define an async function to initialize FlutterFire
  void initializeFlutterFire() async {
    try {
      // Wait for Firebase to initialize and set `_initialized` state to true
      await Firebase.initializeApp();
      setState(() {
        _initialized = true;
      });
    } catch (e) {
      // Set `_error` state to true if Firebase initialization fails
      setState(() {
        _error = true;
      });
    }
  }

  @override
  void initState() {
    initializeFlutterFire();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    builderCounter++;
    print("Called build $builderCounter");
    if (_error) {
      print("Error with Firebase init.  Something went wrong");
    }
    if (!_initialized) {
      print("Firebase init is NOT done");
      //AuthManager().beginListening();
    }

    if (!_error && _initialized) {
      AuthManager().beginListening();
    }

    // Once complete, show your application
    // if (snapshot.connectionState == ConnectionState.done) {
    //   print("ConnectionState.Done with Firebase init");
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      //theme: ThemeData.light(),
      // home: WelcomeScreen(),
      routes: {
        kRouteWelcome: (context) => WelcomeScreen(),
        kRouteChat: (context) => ChatScreen(),
        kRouteLogin: (context) => LoginScreen(),
        kRouteRegistration: (context) => RegistrationScreen(),
      },
      initialRoute: kRouteWelcome,
    );
  }
}
