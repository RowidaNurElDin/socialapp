import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:socialapp/Screens/splash_screen.dart';

class TmpScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 4), () =>
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>  SplashScreen()))
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
        image: DecorationImage(
        image: AssetImage("assets/wallpaper1.png"),
    fit: BoxFit.cover,
    ),
    ),),
    );
  }
}
