import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/introduction_1.dart';
import 'package:ballwizard/screens/lecture.dart';
import 'package:ballwizard/screens/login.dart';
import 'package:ballwizard/screens/register.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/screens/user_info.dart';
import 'package:ballwizard/types.dart'
    show ColorPalette, DrawerElement, FundamentalVariant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget DrawerCustom(
    {required BuildContext context,
    FundamentalVariant variant = FundamentalVariant.light}) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).padding.top,
        child: ColoredBox(
          color: ColorPalette.primary,
        ),
      ),
      DrawerElement(
        title: FirebaseAuth.instance.currentUser?.displayName != null
            ? FirebaseAuth.instance.currentUser!.displayName!
            : "",
        picture: Image.network(
          FirebaseAuth.instance.currentUser!.photoURL!,
          width: 34,
          height: 34,
        ),
        component: UserInformation(),
        context: context,
        color: ColorPalette.primary,
        textColor: ColorPalette.light,
      ),
      DrawerElement(
          title: "Manage user information",
          icon: const Icon(
            Icons.account_circle,
            size: 34,
            color: ColorPalette.dark,
          ),
          component: Start(),
          context: context),
      DrawerElement(
          title: "Log out",
          icon: const Icon(Icons.logout),
          component: Lecture(
              title: "man",
              body: "# obamna\n### big\n- omaga",
              nextLecture: Start(),
              prevLecture: Start()),
          context: context),
      DrawerElement(
          title: "Login",
          icon: const Icon(Icons.logout),
          component: Login(),
          context: context),
      DrawerElement(
          title: "Register",
          icon: const Icon(Icons.people_alt),
          component: Register(),
          context: context),
      DrawerElement(
          title: "Home",
          icon: const Icon(Icons.house),
          component: const Home(),
          context: context),
      DrawerElement(
          title: "Introduction",
          icon: const Icon(Icons.arrow_right_alt_outlined),
          component: const Introduction(),
          context: context),
    ]),
  );
}

/*
SizedBox(
          height: 56,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Row(
                children: [
                  Text(
                    FirebaseAuth.instance.currentUser?.displayName != null
                        ? FirebaseAuth.instance.currentUser!.displayName!
                        : "",
                    style: Fonts.small,
                  ),
                  FirebaseAuth.instance.currentUser?.photoURL != null
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(24),
                          child: Image.network(
                            FirebaseAuth.instance.currentUser!.photoURL!,
                            width: 34,
                            height: 34,
                          ),
                        )
                      : Icon(Icons.account_circle, size: 34)
                ],
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
              ))),
 */
