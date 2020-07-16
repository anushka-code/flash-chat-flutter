import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  Logo ({@required this.height});

  final double height;
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag:'logo',
      child: Container(
        child: Image.asset('images/logo.png'),
        height: height,
      ),
    );
  }
}
