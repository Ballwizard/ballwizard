// ignore_for_file: prefer_const_constructors

import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class SplashScreen extends StatefulWidget {
  SplashScreen({super.key});

  @override
  State<StatefulWidget> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  Timer? timer;

  @override
  void dispose() {
    super.dispose();
    timer?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    timer = Timer(Duration(milliseconds: 1600), () {
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.pushNamedAndRemoveUntil(context, "/home", (r) => false);
      } else {
        Navigator.pushNamedAndRemoveUntil(context, "/intro", (r) => false);
      }
    });

    return MaterialApp(
      home: Scaffold(
        body: FractionallySizedBox(
          widthFactor: 1,
          heightFactor: 1,
          child: GradientBackground(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                "assets/logo.png",
                fit: BoxFit.contain,
                width: 285,
              ),
            ],
          )),
        ),
      ),
    );
  }
}
