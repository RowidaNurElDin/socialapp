import 'dart:async';
import 'package:flutter/material.dart';
import '../Components.dart';
import 'Constants.dart';
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
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/wallpaper1.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: FadeIn(
          duration: Duration(seconds: 5),
          child: Center(
              child: Container(
                height: 120,
                width: 250,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(50)),
                  boxShadow: [BoxShadow(blurRadius: 30, color: Colors.white, spreadRadius: 5)],
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("SPECTRUM" ,
                          style: TextStyle(
                          fontWeight: FontWeight.bold,
                            fontSize: 40,
                            color: Constants.mainColor
                        ),),
                      Text("Homemade Facebook." ,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 10,
                            color: Constants.mainColor
                        ),),
                    ],
                  ),
                ),
              )
          ) ,
        ),
      ),
    );
  }
}
