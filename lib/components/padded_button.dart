import 'package:flutter/material.dart';

class PaddedButton extends StatelessWidget {
  final String text;
  final Function onPressedAction;
  final Color color;

  PaddedButton(
      {@required this.text,
      @required this.onPressedAction,
      this.color = Colors.blueAccent});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressedAction,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            this.text,
            style: TextStyle(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
