import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../globals.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Timer(Duration(seconds: 2), () {
      print(FirebaseAuth.instance.currentUser);
      if (FirebaseAuth.instance.currentUser != null) {
        Navigator.of(context).pushReplacementNamed('/home');
      } else {
        //Navigator.of(context).pushReplacementNamed('/intro');
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
                'assets/logo.png',
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
