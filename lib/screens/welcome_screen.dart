import 'package:flash_chat/screens/login_screen.dart';
import 'package:flash_chat/screens/registration_screen.dart';
import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flash_chat/components/rounded_button.dart';
import 'package:flash_chat/components/logo.dart';

class WelcomeScreen extends StatefulWidget {

  static const String id = 'welcome_screen'; // used for a variable where the value cannot be changed for a class

  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> with SingleTickerProviderStateMixin {
// this mixin is for a single ticker
// for any animation : animation controller, ticker, animation value
  AnimationController controller;
  Animation animation;

  @override

  void initState()
  {
    super.initState();
    controller = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,

    );

    animation = ColorTween(begin: Colors.blueGrey, end: Colors.white).animate(controller);

    controller.forward(); // this actually pushes the animation forward

    controller.addListener( () {
      setState(() {});
    });

  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: animation.value,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Row(
              children: <Widget>[
                Logo(height: 100,),
                TypewriterAnimatedTextKit(
                  text: ['Flash Chat',],
                  textStyle: TextStyle(
                    color: Colors.blueGrey,
                    fontSize: 45.0,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 48.0,
            ),
            RoundedButton(color : Colors.lightBlueAccent,
              title: 'Log In',
              onPressed: ()
              {
                Navigator.pushNamed(context, LoginScreen.id);
              },),

            RoundedButton(color : Colors.blueAccent,
              title: 'Register',
              onPressed: ()
              {
                Navigator.pushNamed(context, RegistrationScreen.id);
              },),
          ],
        ),
      ),
    );
  }
}

