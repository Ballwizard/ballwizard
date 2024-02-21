import 'package:ballwizard/drawer_element.dart';
import 'package:ballwizard/screens/downloaded.dart';
import 'package:ballwizard/screens/feedback.dart';
import 'package:ballwizard/screens/manage_activity.dart';
import 'package:ballwizard/screens/manage_user.dart';
import 'package:ballwizard/screens/start.dart';
import 'package:ballwizard/screens/user_info.dart';
import 'package:ballwizard/types.dart' show ColorPalette, FundamentalVariant;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

Widget DrawerCustom(
    {required BuildContext context,
    FundamentalVariant variant = FundamentalVariant.light}) {
  return Drawer(
    backgroundColor: ColorPalette.light,
    child: ListView(padding: EdgeInsets.zero, children: <Widget>[
      SizedBox(
        height: MediaQuery.of(context).padding.top,
        child: const ColoredBox(
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
        component: const UserInformation(),
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
          component: ManageUser(),
          context: context),
      DrawerElement(
          title: "Log out",
          icon: const Icon(Icons.logout, size: 30, color: ColorPalette.dark),
          component: Start(),
          context: context,
          clearHistory: true),
      DrawerElement(
          title: "Send feedback",
          icon: const Icon(Icons.info, size: 32, color: ColorPalette.dark),
          component: const FeedbackScreen(),
          context: context),
      DrawerElement(
          title: "Manage activity",
          icon: const Icon(
            Icons.manage_history,
            size: 32,
            color: ColorPalette.dark,
          ),
          component: const ManageActivity(),
          context: context),
      DrawerElement(
          title: "Downloaded lectures",
          icon: const Icon(
            Icons.download,
            size: 32,
            color: ColorPalette.dark,
          ),
          component: const DownloadedLectures(),
          context: context),
    ]),
  );
}
