import 'package:ballwizard/globals.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Modal extends StatefulWidget {
  const Modal({super.key});

  @override
  State<Modal> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<Modal> {
  Widget ButtonWidget(String text, func, isRed) {
    return SizedBox(
      width: 80,
      height: 40,
      child: ElevatedButton(
        onPressed: func,
        child: Text(text),
        style: ElevatedButton.styleFrom(
            primary: isRed ? ColorPalette.danger : ColorPalette.light,
            foregroundColor: isRed ? ColorPalette.light : ColorPalette.dark),
      ),
    );
  }

  User? user = FirebaseAuth.instance.currentUser;
  Future<void> deleteAccount() async {
    try {
      await user?.delete(); //this will delete user
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: TextStyle(color: Colors.white),
      child: Container(
        color: const Color(0x80808080),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.transparent,
                    border: Border.all(color: ColorPalette.danger, width: 3)),
                width: 300,
                height: 200,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Are you sure you want to delete your account?',
                        style: Fonts.medium,
                        textAlign: TextAlign.center,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        width: 200,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            ButtonWidget('Yes', deleteAccount, true),
                            ButtonWidget('No', () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StartPage()));
                            }, false)
                          ],
                        ),
                      )
                    ]),
              )
            ]),
      ),
    );
  }
}
