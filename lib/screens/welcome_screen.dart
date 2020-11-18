import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/padded_button.dart';
import 'package:flash_chat/constants.dart';
import 'package:flutter/material.dart';

class WelcomeScreen extends StatefulWidget {
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation animation;

  @override
  void initState() {
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 400),
      // upperBound: 100.0,
    );

    // animation = CurvedAnimation(
    //   parent: controller,
    //   curve: Curves.decelerate,
    // );
    // animation.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     controller.reverse(from: 1.0);
    //   } else if (status == AnimationStatus.dismissed) {
    //     controller.forward();
    //   }
    // });

    animation = ColorTween(begin: Colors.lightBlueAccent, end: Colors.white)
        .animate(controller);

    controller.forward();
    controller.addListener(() {
      setState(() {});
      // print(controller.value);
      // print(animation.value);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.red.withOpacity(controller.value),
      // backgroundColor: Colors.white,
      backgroundColor: animation.value, // Used with ColorTween
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                children: <Widget>[
                  Hero(
                    tag: kTagLightningLogo,
                    child: Container(
                      child: Image.asset('images/logo.png'),
                      height: 60.0,
                      // height: controller.value,
                      // height: animation.value * 100.0,
                    ),
                  ),
                  TypewriterAnimatedTextKit(
                    text: ['Flash Chat'],
                    isRepeatingAnimation: false,
                    speed: Duration(milliseconds: 300),
                    // "${controller.value.toStringAsFixed(0)}%",
                    textStyle: TextStyle(
                        fontSize: 45.0,
                        fontWeight: FontWeight.w900,
                        color: Colors.black),
                  ),
                ],
              ),
              SizedBox(
                height: 48.0,
              ),
              PaddedButton(
                text: "Log In",
                onPressedAction: () {
                  Navigator.pushNamed(context, kRouteLogin);
                },
                color: Colors.lightBlueAccent,
              ),
              PaddedButton(
                  text: "Register",
                  onPressedAction: () {
                    Navigator.pushNamed(context, kRouteRegistration);
                  },
                  color: Colors.blueAccent),
            ]),
      ),
    );
  }
}
