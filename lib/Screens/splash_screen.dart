import 'dart:async';
import 'package:flutter/material.dart';
import '../Components.dart';
import 'login_screen.dart';
import 'package:flutter_fadein/flutter_fadein.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 5), () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  SocialLogin()))
    );
    return Scaffold(
      backgroundColor: Colors.white,
      body: FadeIn(
        child: Center(child: Components.mobileLogo()) ,
        duration: Duration(seconds: 3),
      ),
    );
  }
}
