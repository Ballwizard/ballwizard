import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/home.dart';
import 'package:ballwizard/screens/login.dart';
import 'package:ballwizard/screens/register.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart'
    show ColorPalette, DrawerElement, FundamentalVariant;
import 'package:flutter/material.dart';

Widget DrawerCustom(
    {required BuildContext context,
    FundamentalVariant variant = FundamentalVariant.light}) {
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      SizedBox(height: MediaQuery.of(context).padding.top),
      SizedBox(
          height: 56,
          child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22),
              child: Container(
                  child: Icon(Icons.account_circle, size: 34),
                  alignment: Alignment.centerRight))),
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
          component: Start(),
          context: context),
      DrawerElement(
          title: "Login",
          icon: const Icon(Icons.logout),
          component: Login(),
          context: context),
      DrawerElement(
          title: "Register",
          icon: const Icon(Icons.people_alt),
          component: const Register(),
          context: context),
      DrawerElement(
          title: "Home",
          icon: const Icon(Icons.house),
          component: const Home(),
          context: context),
    ]),
  );
}
