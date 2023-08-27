import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/types.dart' show FundamentalVariant, DrawerElement;
import 'package:flutter/material.dart';

Widget DrawerCustom(
    {required BuildContext context,
    FundamentalVariant variant = FundamentalVariant.light}) {
  int selected = 0;
  return Drawer(
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      DrawerElement(
          title: "Manage user information",
          icon: const Icon(Icons.account_circle),
          component: const Start(),
          context: context),
      DrawerElement(
          title: "Log out",
          icon: const Icon(Icons.logout),
          component: const Start(),
          context: context),
    ]),
  );
}
