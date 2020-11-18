import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';
import 'package:flash_chat/screens/welcome_screen.dart';
import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flash_chat/screens/chat_screen.dart';

void main() => runApp(FlashChat());

class FlashChat extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // theme: ThemeData.dark().copyWith(
      //   textTheme: TextTheme(
      //     bodyText1: TextStyle(color: Colors.black54),
      //   ),
      // ),
      theme: ThemeData.light(),
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
