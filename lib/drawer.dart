import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/feedback.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/introduction_1.dart';
import 'package:ballwizard/screens/login.dart';
import 'package:ballwizard/screens/register.dart';
import 'package:ballwizard/screens/splash.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/screens/user_info.dart';
import 'package:ballwizard/types.dart'
    show ColorPalette, DrawerElement, FundamentalVariant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
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
        picture: FirebaseAuth.instance.currentUser?.photoURL != null
            ? Image.network(
                FirebaseAuth.instance.currentUser!.photoURL!,
                width: 34,
                height: 34,
              )
            : null,
        icon: const Icon(
          Icons.account_circle,
          size: 34,
          color: ColorPalette.light,
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
          component: SplashScreen(),
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
      DrawerElement(
          title: "Send feedback",
          icon: const Icon(Icons.info, color: ColorPalette.dark),
          component: FeedbackScreen(),
          context: context),
      GestureDetector(
        onTap: (){
          FirebaseAuth.instance.signOut();
        },
        child: Text("actual log out"),
      ),
      GestureDetector(
        onTap: (){
          print(FirebaseAuth.instance.currentUser != null);
        },
        child: Text("check if logged in"),
      )
    ]),

  );
}
