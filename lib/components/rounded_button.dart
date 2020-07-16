import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  RoundedButton({this.color, this.title, @required this.onPressed});

  // @required is te required parameter in the constructor, without which
  //it shows and error
  // the constructor has all the features to customise our rounded button

  final Color color;
  final String title;
  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        elevation: 5.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onPressed,
          minWidth: 200.0,
          height: 42.0,
          child: Text(
            title,
            style : TextStyle(
              color : Colors.white,
              fontSize: 20.0,
            ),
          ),
        ),
      ),
    );
  }
}
