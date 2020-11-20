import 'package:flash_chat/components/padded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flash_chat/managers/auth_manager.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  String email;
  String password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Hero(
              tag: kTagLightningLogo,
              child: Container(
                height: 200.0,
                child: Image.asset('images/logo.png'),
              ),
            ),
            SizedBox(
              height: 48.0,
            ),
            TextField(
              textAlign: TextAlign.center,
              keyboardType: TextInputType.emailAddress,
              onChanged: (value) {
                //Do something with the user input.
                email = value;
              },
              decoration: kTextFieldEmailDecoration,
            ),
            SizedBox(
              height: 8.0,
            ),
            TextField(
              obscureText: true,
              textAlign: TextAlign.center,
              onChanged: (value) {
                //Do something with the user input.
                password = value;
              },
              decoration: kTextFieldPasswordDecoration,
            ),
            SizedBox(
              height: 24.0,
            ),
            PaddedButton(
              text: "Register",
              onPressedAction: () async {
                print("Register $email $password");
                final newUser = await AuthManager().createUser(email, password);
                if (newUser != null) {
                  Navigator.pushNamed(context, kRouteChat);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
